nginx_group:
  group.present:
    - name: nginx
    - system: True

nginx_user:
  file.directory:
    - name: /opt/nginx
    - user: nginx
    - group: nginx
    - mode: 0755
    - require:
      - user: nginx_user
      - group: nginx_group
  user.present:
    - name: nginx
    - groups:
      - nginx
    - system: True
    - home: /opt/nginx
    - shell: /bin/bash
    - require:
      - group: nginx_group

nginx-yum-repo:
  pkgrepo.managed:
    - humanname: Nginx Repository
    - baseurl: http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
    - gpgcheck: 0
  pkg.installed:
    - pkgs:
      - nginx

/etc/nginx/conf.d/default.conf:
  file.managed:
    - source: salt://images/nginx-default.conf
    - user: root
    - group: root
    - mode: 700

/opt/vagrantboxes:
  directory.managed:
    - user: nginx
    - group: nginx
    - mode: 777

restart-nginx:
  service.restart:
    -name: nginx

