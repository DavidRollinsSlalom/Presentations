#include:
#   - bamboo.common

install postgres:
  pkg.installed:
    - pkgs:
      - postgresql

create user:
  postgres.user_create:
    - 'bamboo'
    - password: 'bamboo'

create db:
  postgres.db_create:
    - name: bamboo
    - owner: bamboo

/opt/bamboo/downloads:
  file.directory:
    - user: bamboo
    - group: bamboo
    - mode: 644
    - makedirs: True

bamboo-server-download:
  file.managed:
    - name: /opt/bamboo/downloads/atlassian-bamboo-5.9.7.tar.gz
    - source: https://downloads.atlassian.com/software/bamboo/downloads/atlassian-bamboo-5.9.7.tar.gz
    - source_hash: md5=f65658250bed4f61152fb833c52bd23f
    - user: bamboo
    - group: bamboo
    - mode: 644

untar_file:
  module.run:
    - name: archive.tar
    - options: xzvf
    - tarfile: /opt/bamboo/downloads/atlassian-bamboo-5.9.7.tar.gz
    - dest: /opt/bamboo/5.9.7/

/opt/bamboo/5.9.7:
  file.symlink:
    - target: /opt/bamboo/server/current
  
/opt/bamboo/current/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties:
  file.managed:
    - source: salt://bamboo/files/bamboo-init.properties
    - user: bamboo
    - group: bamboo
    - mode: 644

/etc/systemd/system/bamboo-server.service:
  file.managed:
    - source: salt://bamboo/files/bamboo-server.service
    - user: root
    - group: root
    - mode: 644

bamboo-server-service:
  service.running:
    - name: bamboo-server
    - enable: True

