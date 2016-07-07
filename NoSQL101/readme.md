# No SQL: 101


### Purpose

This vagrant setup acts as the virtual machine to ease setup and configuration for developers

It uses the SAME configuration & setup steps that we use for our DEV and CI environments (using the Salt formulas to provision).

Included in this server instance is:
- CentOS 7.1
- MongoDB
- ElasticSearch

## Prerequisites:

1. Install Vagrant (1.7.1 or greater)
	- https://www.vagrantup.com/downloads.html
1. Install Oracle Virtual Box 4.3.3 or greater (May work on others, but that's what I use)
	- https://www.virtualbox.org/wiki/Downloads


## Setting up included VM

1. Clone or Download this repo
1. Go to Presentations/NoSQL101/platform directory

```
cd ./Presentations/NoSQL101/platform
```

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




