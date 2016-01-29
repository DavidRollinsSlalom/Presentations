copy_my_files:
  file.recurse:
    - source: salt://opt/Jenkins_FS/ng-scp-worker-0.9.1_DEV_SNAPSHOT.rpm
    - target: /opt/Salt/
    - makedirs: True
