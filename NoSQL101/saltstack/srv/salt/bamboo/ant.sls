download-and-extract-apache-ant-tarball:
  archive.extracted:
    - name: /opt
    - source: http://apache.cs.utah.edu/ant/binaries/apache-ant-1.9.6-bin.tar.gz
    - source_hash: md5=f1d2e99df927a141c355210d55fe4d32
    - archive_format: tar
    - tar_options: v
    - if_missing: /opt/apache-ant-1.9.6/

apache-ant-home:
  alternatives.install:
    - link: /opt/apache-ant
    - path: /opt/apache-ant-1.9.6
    - priority: 30

/etc/profile.d/apache-ant.sh:
  file.managed:
    - source: salt://bamboo/files/apache-ant.sh
    - mode: 644
    - user: root
    - group: root

download-ant-mail-jar:
  file.managed:
    - name: /opt/apache-ant-1.9.6/lib/mail.jar
    - source: http://search.maven.org/remotecontent?filepath=javax/mail/mail/1.4.4/mail-1.4.4.jar
    - source_hash: md5=f30453ae9ee252c802d349009742065f
    - user: root
    - group: root
    - mode: 644

download-ant-activation-jar:
  file.managed:
    - name: /opt/apache-ant-1.9.6/lib/activation.jar
    - source: http://search.maven.org/remotecontent?filepath=javax/activation/activation/1.1/activation-1.1.jar
    - source_hash: md5=8ae38e87cd4f86059c0294a8fe3e0b18
    - user: root
    - group: root
    - mode: 644

