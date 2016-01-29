nexus_group:
  group.present:
    - name: nexus
    - system: True

nexus_user:
  file.directory:
    - name: /opt/nexus
    - user: nexus
    - group: nexus
    - mode: 0755
    - require:
      - user: nexus_user
      - group: nexus_group
  user.present:
    - name: nexus
    - groups:
      - nexus
    - system: True
    - home: /opt/nexus
    - shell: /bin/bash
    - require:
      - group: nexus_group


jre:
  pkg.installed:
    - pkgs:
      - wget
  cmd.run:
    - name: |
        wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jre-8u45-linux-x64.rpm"
        yum localinstall jre-8u45-linux-x64.rpm -y

nexus-server:
  pkg.installed:
    - pkgs:
      - wget
  cmd.run:
    - user: nexus
    - name: |
        wget http://www.sonatype.org/downloads/nexus-latest-bundle.tar.gz
        tar xzvf nexus-latest-bundle.tar.gz -C /opt/nexus
        ln -s /opt/nexus/nexus-2.11.4-01 /opt/nexus/latest

forward-port-80:
  pkg.installed:
    - pkgs:
      - iptables-services
  cmd.run:
    - name: |
        #firewall-cmd --zone=public --add-masquerade --permanent
        #firewall-cmd --zone=public --add-forward-port=port=80:proto=tcp:toport=8081 --permanent
        systemctl stop firewalld
        systemctl mask firewalld
        systemctl enable iptables
        systemctl start iptables
        #IFACE=`ip route get "10.70.240.59" | grep -Po '(?<=(dev )).*(?= src)'`
        iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination :8081
        service iptables save
        iptables -F

/etc/sysconfig/nexus:
  file.managed:
    - source: salt://nexus/nexus.env
    - user: root
    - group: root
    - mode: 644

/opt/nexus/latest/conf/nexus.properties:
  file.managed:
    - source: salt://nexus/nexus.properties
    - user: nexus
    - group: nexus
    - mode: 644

/etc/systemd/system/nexus.service:
  file.managed:
    - source: salt://nexus/nexus.service
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: nexus
    - enable: True


