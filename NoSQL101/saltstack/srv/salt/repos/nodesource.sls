nodesource:
  file.managed:
    - name: /etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL
    - source: salt://repos/files/NODESOURCE-GPG-SIGNING-KEY-EL
  pkgrepo.managed:
    - humanname: Node.js for Enterprise Linux 7
    - name: nodesource
    - baseurl: https://rpm.nodesource.com/pub_0.12/el/7/x86_64/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL
