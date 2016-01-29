
download-and-extract-soapui-tarball:
  archive.extracted:
    - name: /opt/soapui-5.2.1
    - source: http://cdn01.downloads.smartbear.com/soapui/5.2.1/SoapUI-5.2.1-linux-bin.tar.gz
    - source_hash: md5=ba51c369cee1014319146474334fb4e1
    - archive_format: tar
    - tar_options: --strip-components=1
    - if_missing: /opt/soapui-5.2.1/

soapui-home:
  alternatives.install:
    - link: /opt/soapui
    - path: /opt/soapui-5.2.1
    - priority: 30

/etc/profile.d/soapui.sh:
  file.managed:
    - source: salt://bamboo/files/soapui.sh
    - mode: 644
    - user: root
    - group: root
