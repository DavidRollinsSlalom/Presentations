include:
  - repos.epel
 
base:
  pkg.installed:
    - pkgs:
      - zip
      - unzip
      - curl
      - wget
      - vim-enhanced
      - git

/etc/motd:
  file.managed:
    - source: salt://nextgen/files/motd
    - user: root
    - group: root
    - mode: 644

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nextgen/files/nginx.conf
    - user: root
    - group: root
    - mode: 644

/usr/share/nginx/html/index.html:
  file.managed:
    - source: salt://nextgen/files/html/index.html
    - user: root
    - group: root
    - mode: 644

/usr/share/nginx/html/whale.gif:
  file.managed:
    - source: salt://nextgen/files/html/whale.gif
    - user: root
    - group: root
    - mode: 644

tailon:
  pkg.installed:
    - pkgs:
      - python-pip
  pip.installed:
    - name: tailon
  file.managed:
    - name: /etc/systemd/system/tailon.service
    - source: salt://nextgen/files/tailon.service
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: tailon
    - enable: true