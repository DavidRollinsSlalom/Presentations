include:
   - repos.epel

virtualbox:
  pkgrepo.managed:
    - humanname: VirtualBox Repository
    - name: virtualbox
    - baseurl: http://download.virtualbox.org/virtualbox/rpm/rhel/7/x86_64/
    - gpgcheck: 0
  pkg.installed:
    - pkgs:
      - dkms
      - VirtualBox-5.0

vagrant:
  cmd.run:
    - name: |
        rpm -Uvh https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.rpm
