# for CI boxes - need to be able to log in to install RPMs
bamboo_user:
  group.present:
    - name: bamboo
    - system: false
  user.present:
    - name: bamboo
    - password: bamboo
    - groups:
      - bamboo
    - system: false
    - home: /opt/bamboo
    - shell: /bin/bash

/opt/bamboo/.ssh:
  file.directory:
    - user: bamboo
    - group: bamboo
    - mode: 700
    - makedirs: True

/opt/bamboo/.ssh/authorized_keys:
  file.managed:
    - source: salt://nextgen/files/authorized_keys
    - user: bamboo
    - group: bamboo
    - mode: 600

/opt/bamboo/.bashrc:
  file.managed:
    - source: salt://nextgen/files/bamboo.bashrc
    - user: bamboo
    - group: bamboo
    - mode: 644

/etc/sudoers.d/bamboo_sudo:
  file.managed:
    - source: salt://nextgen/files/bamboo_sudo
    - user: root
    - group: root
    - mode: 600