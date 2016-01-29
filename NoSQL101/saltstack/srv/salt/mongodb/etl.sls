# For mongodump and mongorestore
mongodb:
  pkgrepo.managed:
    - humanname: MongoDB Repository
    - name: mongodb
    - baseurl: http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
    - gpgcheck: 0
  pkg.installed:
    - fromrepo: mongodb
    - pkgs:
      - mongodb-org-shell: 2.6.10-1
      - mongodb-org-tools: 2.6.10-1

