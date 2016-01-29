swagger_group:
  group.present:
    - name: swagger
    - system: True

swagger_user:
  file.directory:
    - name: /opt/swagger
    - user: swagger
    - group: swagger
    - mode: 0755
    - require:
      - user: swagger_user
      - group: swagger_group
  user.present:
    - name: swagger
    - groups:
      - swagger
    - system: True
    - home: /opt/swagger
    - shell: /bin/bash
    - require:
      - group: swagger_group

node:
  pkg.installed:
    - pkgs:
      - wget
  cmd.run:
    - user: swagger
    - name: |
        wget http://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz
        tar xzvf node-v0.12.7-linux-x64.tar.gz
        ln -s node-v0.12.7-linux-x64 node
        echo export PATH='~/node/bin:$PATH' >> ~/.bash_profile

swagger-editor:
  pkg.installed:
    - pkgs:
      - wget
      - git
      - psmisc
      - gcc-c++
      - unzip
  cmd.run:
    - user: swagger
    - name: |
        . ~/.bash_profile
        npm install -g http-server
        wget https://github.com/swagger-api/swagger-editor/releases/download/v2.9.8/swagger-editor.zip
        unzip swagger-editor.zip
        mkdir web
        mv swagger-editor web/editor

swagger-ui:
  pkg.installed:
    - pkgs:
      - git
  cmd.run:
    - user: swagger
    - name: |
        git clone https://github.com/swagger-api/swagger-ui.git
        mv swagger-ui/dist web/ui

cors-it:
  pkg.installed:
    - pkgs:
      - git
  cmd.run:
    - user: swagger
    - name: |
        . ~/.bash_profile
        git clone https://github.com/mohsen1/cors-it.git
        cd cors-it
        npm install

/etc/sysconfig/swagger:
  file.managed:
    - source: salt://swagger/swagger.env
    - user: root
    - group: root
    - mode: 644

/etc/systemd/system/swagger.service:
  file.managed:
    - source: salt://swagger/swagger.service
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: swagger
    - enable: True

/etc/systemd/system/cors-it.service:
  file.managed:
    - source: salt://swagger/cors-it.service
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: cors-it
    - enable: True

/etc/systemd/system/validator-badge.service:
  file.managed:
    - source: salt://swagger/validator-badge.service
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: validator-badge
    - enable: True

/etc/sysconfig/iptables:
  pkg.installed:
    - pkgs:
      - iptables-services
  file.managed:
    - source: salt://swagger/sysconfig-iptables
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: |
        #firewall-cmd --zone=public --add-masquerade --permanent
        #firewall-cmd --zone=public --add-forward-port=port=80:proto=tcp:toport=8080 --permanent
        systemctl stop firewalld
        systemctl mask firewalld
        systemctl enable iptables
        systemctl start iptables

