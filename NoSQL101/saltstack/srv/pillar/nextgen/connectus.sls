beacons:
  inotify:
    /opt/Shaker/testBeacon.log:
      mask:
        - open
        - create
        - modify
      recurse: True
      auto_add: True
