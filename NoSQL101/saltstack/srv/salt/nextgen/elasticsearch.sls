include:
   - java.oracle-jre-8
   - repos.epel
   - repos.nodesource

elasticsearch:
  pkgrepo.managed:
    - humanname: Elasticsearch repository
    - name: elasticsearch
    - baseurl: http://packages.elastic.co/elasticsearch/1.7/centos
    - gpgcheck: 0
  pkg.installed:
    - fromrepo: elasticsearch
    - pkgs:
      - elasticsearch
  cmd.run:
    - name: |
        /usr/share/elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ
        /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://nextgen/files/elasticsearch.yml
    - user: root
    - group: root
    - mode: 644
    - template: jinja
  service.running:
    - name: elasticsearch
    - enable: True

node-packages:
  pkg.installed:
    - fromrepo: nodesource
    - name: nodejs
  npm.installed:
    - registry:  http://psl-devnexus01.lab.securustech.net/content/groups/npm/
    - pkgs:
      - elasticdump

