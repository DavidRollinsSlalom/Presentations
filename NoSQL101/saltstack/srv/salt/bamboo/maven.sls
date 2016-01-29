download-and-extract-maven-tarball:
  archive.extracted:
    - name: /opt
    - source: http://www.us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
    - source_hash: md5=516923b3955b6035ba6b0a5b031fbd8b
    - archive_format: tar
    - tar_options: v
    - if_missing: /opt/apache-maven-3.3.9/

apache-maven-home:
  alternatives.install:
    - link: /opt/apache-maven
    - path: /opt/apache-maven-3.3.9
    - priority: 30

/etc/profile.d/apache-maven.sh:
  file.managed:
    - source: salt://bamboo/files/apache-maven.sh
    - mode: 644
    - user: root
    - group: root

