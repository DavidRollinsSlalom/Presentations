epel:
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
    - source: salt://repos/files/RPM-GPG-KEY-EPEL-7
  pkgrepo.managed:
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - name: epel
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

