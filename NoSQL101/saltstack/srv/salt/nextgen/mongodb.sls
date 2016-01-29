mongodb_group:
  group.present:
    - name: mongodb
    - system: true

mongodb_user:
  file.directory:
    - name: /opt/mongodb
    - user: mongodb
    - group: mongodb
    - mode: 0755
    - require:
      - user: mongodb_user
      - group: mongodb_group
  user.present:
    - name: mongodb
    - groups:
      - mongodb
    - system: True
    - home: /opt/mongodb
    - shell: /bin/bash
    - require:
      - group: mongodb_group

mongodb:
  pkgrepo.managed:
    - humanname: MongoDB Repository
    - name: mongodb
    - baseurl: http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
    - gpgcheck: 0
  pkg.installed:
    - fromrepo: mongodb
    - pkgs:
      - mongodb-org: 2.6.10-1
      - mongodb-org-server: 2.6.10-1
      - mongodb-org-shell: 2.6.10-1
      - mongodb-org-mongos: 2.6.10-1
      - mongodb-org-tools: 2.6.10-1
  cmd.run:
    - name: |
        sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
        chown mongodb:mongodb /etc/mongod.conf
  service.running:
    - name: mongod
    - enable: True

