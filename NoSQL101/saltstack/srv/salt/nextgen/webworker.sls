include:
  - java.oracle-jre-8
  - nextgen.disable-securus-repos
  - repos.epel
  - repos.nodesource
  - repos.centos
  - mongodb.etl

base:
  pkg.installed:
    - pkgs:
      - zip
      - unzip
      - curl
      - wget
      - vim-enhanced
      - git

#####################
# Hazelcast
#####################
hazelcast_group:
  group.present:
    - name: hazelcast
    - system: true

hazelcast_user:
  file.directory:
    - name: /opt/hazelcast
    - user: hazelcast
    - group: hazelcast
    - mode: 0755
    - require:
      - user: hazelcast_user
      - group: hazelcast_group
  user.present:
    - name: hazelcast
    - groups:
      - hazelcast
    - system: true
    - home: /opt/hazelcast
    - shell: /bin/bash
    - require:
      - group: hazelcast_group

mancenter:
  pkg.installed:
    - pkgs:
      - wget
      - unzip
  cmd.run:
    - user: hazelcast
    - name: |
        wget -q -O hazelcast-3.3.3.zip "http://download.hazelcast.com/download.jsp?version=hazelcast-3.3.3&p=107143050"
        unzip hazelcast-3.3.3.zip
        ln -sf hazelcast-3.3.3 latest
        chmod +x latest/mancenter/startManCenter.sh

/etc/systemd/system/mancenter.service:
  file.managed:
    - source: salt://nextgen/files/mancenter.service
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: mancenter
    - enable: true

#####################
# nginx
#####################
nginx:
  pkg.installed:
    - pkgs:
      - nginx

nginx-service:
  service.running:
    - name: nginx
    - reload: true
    - enable: true

#####################
# haproxy
#####################
haproxy:
  pkg.installed:
    - pkgs:
      - haproxy

haproxy-service:
  service.running:
    - name: haproxy
    - reload: true
    - enable: true

# elasticdump
node-packages:
  pkg.installed:
    - fromrepo: nodesource
    - name: nodejs
  npm.installed:
    - registry:  http://psl-devnexus01.lab.securustech.net/content/groups/npm/
    - pkgs:
      - elasticdump


