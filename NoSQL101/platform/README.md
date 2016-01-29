# NG-SCP Vagrant Platform

### Purpose

This vagrant setup acts as the virtual machine to ease setup and configuration for developers

It uses the SAME configuration & setup steps that we use for our DEV and CI environments (using the Salt formulas to provision).

Included in this server instance is:
- CentOS 7.1
- MongoDB
- Hazelcast Mancenter
- ElasticSearch
- Data from the Dev environment

### How to Use

If you are curious as to where the *.sh files went to & how they migrated into salt states, you can view them here:  http://psl-devgit01.lab.securustech.net/projects/AUTO/repos/saltstack/browse/srv/salt/nextgen

The salt directory is mounted in the vagrant box as /srv/salt, allowing the salt formulas to be executed locally inside of the masterless minion.

To Run:
* As a peer of ng-scp and platform folders, git clone http://psl-devgit01.lab.securustech.net/projects/AUTO/repos/saltstack repo
* “vagrant destroy -f && vagrant up“ inside of platform – it will use the salt provisioner

## Prerequisites:
- Oracle Virtual Box 4.3.3 or greater
- Vagrant 1.7.1 or greater
- You must git clone securus-ng-scp/saltstack as a peer to this directory, so that vagrant can access the salt formulas to provision the vagrant box


### Create a new instance:
change directory to the platform project
```
vagrant up
```

This will download and configure the new instance.


### Stop the VM
```
vagrant halt
```

### Destroy and Recreate the VM
```
vagrant destroy
vagrant up
```

### To access the shell of the VM
```
vagrant ssh
```

### Recreate and update all data
```
vagrant provision
```



## Admin UI

[Hazelcast ManCenter](http://localhost:9001/mancenter/login.jsp)

[ElasticSearch HQ](http://localhost:9200/_plugin/HQ/)



