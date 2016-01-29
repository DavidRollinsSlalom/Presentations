bamboo_user:
  group.present:
    - name: bamboo
    - system: True
  user.present:
    - name: bamboo
    - groups:
      - bamboo
    - system: True
    - home: /opt/bamboo
    - shell: /bin/bash

