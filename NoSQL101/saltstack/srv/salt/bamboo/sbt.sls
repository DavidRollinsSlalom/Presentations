download-and-extract-sbt-tarball:
  archive.extracted:
    - name: /opt/sbt-0.13.8
    - source: https://dl.bintray.com/sbt/native-packages/sbt/0.13.8/sbt-0.13.8.tgz
    - source_hash: md5=329277c380b98ff832c8155072ab88d6
    - archive_format: tar
    - tar_options: --strip-components=1
    - if_missing: /opt/sbt-0.13.8/

apache-sbt-home:
  alternatives.install:
    - link: /opt/sbt
    - path: /opt/sbt-0.13.8
    - priority: 30

/etc/profile.d/sbt.sh:
  file.managed:
    - source: salt://bamboo/files/sbt.sh
    - mode: 644
    - user: root
    - group: root

