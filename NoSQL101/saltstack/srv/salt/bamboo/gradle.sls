download-and-extract-gradle-zip:
  pkg.installed:
    - pkgs:
      - unzip
  archive.extracted:
    - name: /opt
    - source: https://services.gradle.org/distributions/gradle-2.10-bin.zip
    - source_hash: md5=5b8ad24373252dabce9dead708e409f8
    - archive_format: zip
    - if_missing: /opt/gradle-2.1.0/
    - keep: true

gradle-home:
  alternatives.install:
    - link: /opt/gradle
    - path: /opt/gradle-2.10
    - priority: 30

/etc/profile.d/gradle.sh:
  file.managed:
    - source: salt://bamboo/files/gradle.sh
    - mode: 644
    - user: root
    - group: root
