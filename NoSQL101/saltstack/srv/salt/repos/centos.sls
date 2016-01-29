CentOS-Key:
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    - source: salt://repos/files/RPM-GPG-KEY-CentOS-7

CentOS-Base:
  pkgrepo.managed:
    - name: base
    - humanname: CentOS-$releasever - Base
    - mirrorlist: http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
    #baseurl: http://mirror.centos.org/centos/$releasever/os/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

CentOS-Updates:
  pkgrepo.managed:
    - name: updates
    - humanname: CentOS-$releasever - Updates
    - mirrorlist: http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra
    #baseurl: http://mirror.centos.org/centos/$releasever/updates/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

CentOS-Extras:
  pkgrepo.managed:
    - name: extras
    - humanname: CentOS-$releasever - Extras
    - mirrorlist: http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra
    #baseurl: http://mirror.centos.org/centos/$releasever/extras/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

CentOS-Plus:
  pkgrepo.managed:
    - name: centosplus
    - humanname: CentOS-$releasever - Plus
    - mirrorlist: http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra
    #baseurl: http://mirror.centos.org/centos/$releasever/centosplus/$basearch/
    - gpgcheck: 1
    - enabled: 0
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7