# common between agent and server
# most programs that need to be installed on build boxes should go here, so that 
# they are available across both local and remote agents

include:
   - bamboo.user
   - bamboo.nodejs
   - bamboo.java
   - bamboo.vagrant
   - bamboo.soapui
   - bamboo.sbt
   - repos.epel
   - mongodb.etl

/etc/sysconfig/bamboo:
  file.managed:
    - source: salt://bamboo/files/bamboo.env
    - user: root
    - group: root
    - mode: 644

/opt/bamboo/.ivy2:
  file.directory:
    - user: bamboo
    - group: bamboo
    - mode: 744
    - makedirs: True

/opt/bamboo/.ivy2/.securus_credentials:
  file.managed:
    - source: salt://bamboo/files/ivy2_securus_credentials
    - user: bamboo
    - group: bamboo
    - mode: 644

packages:
  pkg.installed:
    - pkgs:
      - wget
      - bzip2
      - psmisc
      - git
      - subversion
      - ncdu
      - htop
      - rpm-build

