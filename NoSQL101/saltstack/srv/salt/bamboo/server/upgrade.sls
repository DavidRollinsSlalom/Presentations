# https://confluence.atlassian.com/bamboo/bamboo-upgrade-guide-720411366.html#Bambooupgradeguide-1.ExportandbackuptheexistingBamboodata

backup-the-existing-bamboo-data:
  service.stopped:
    - name: bamboo
  cmd.run:
    - user: bamboo
    - name: |
        pg_dump -U bamboo bamboo -f /opt/bamboo/bamboo-sql-backup-`date +"%m-%d-%Y"`.sql
        tar czf /opt/bamboo/bamboo-home-backup-`date +"%m-%d-%Y"`.tar.gz /opt/atlassian/bamboo/home/*

download-and-install-new-instance:
  cmd.run:
    - user: bamboo
    - name: |
        wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.9.7.tar.gz
        tar xzvf atlassian-bamboo-5.9.7.tar.gz
        ln -s atlassian-bamboo-5.9.7 current

hipchat-message:
  hipchat.send_message:
    - room_id: 2070542
    - from_name: SaltStack
    - message: 'Bamboo server upgraded by saltstack on {{ grains['host'] }} ({{ grains['ipv4'][0] }}).'
    - api_key: 1c83d83e4af34ee02eb10f2d7bdd1f
    - api_version: v1

