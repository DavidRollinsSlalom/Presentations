CreateDirs:
  cmd.cmd.run:
    - tgt: {{ data['id'] }}
    - arg: |
        mkdir /srv/salt -p
        mkdir /srv/pillar -p
