saltstack-repo:
  file.managed:
    - name: /etc/pki/rpm-gpg/SALTSTACK-GPG-KEY.pub
    - source: salt://repos/files/SALTSTACK-GPG-KEY.pub
  pkgrepo.managed:
    - humanname: SaltStack repo for RHEL/CentOS 7
    - name: saltstack-repo
    - baseurl: https://repo.saltstack.com/yum/rhel7
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/SALTSTACK-GPG-KEY.pub
