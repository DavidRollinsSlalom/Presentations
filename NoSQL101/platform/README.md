# Demo Vagrant Platform

### Purpose

This vagrant setup acts as the virtual machine to ease setup and configuration for developers

It uses the SAME configuration & setup steps that we use for our DEV and CI environments (using the Salt formulas to provision).

Included in this server instance is:
- CentOS 7.1
- MongoDB
- Hazelcast Mancenter
- ElasticSearch

To Run:
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

[ElasticSearch HQ](http://localhost:9200/_plugin/HQ/)



[MongoDB] - localhost:27017

Use MongoClient or RoboMongo to connect.




