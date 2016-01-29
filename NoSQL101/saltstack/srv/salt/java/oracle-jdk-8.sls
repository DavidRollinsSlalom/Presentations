include:
  - repos.appdev

oracle-jdk-8:
  pkg.installed:
    - fromrepo: appdev
    - name: jdk1.8.0_60
