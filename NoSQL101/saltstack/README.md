# saltstack

A collection of saltstack formulas for AppDev

Saltstack master is es-ppsaltm01.pp.securustech.net (10.70.240.59).

# Table of Contents

* [Useful links](#useful-links)
* [How to list current minions](#how-to-list-current-minions)
* [How to salt a new machine](#how-to-salt-a-new-machine)
* [How to run salt states from the salt master](#how-to-run-salt-states-from-the-salt-master)


<a name="useful-links"></a>
# Useful links

* [Saltstack Docs](http://docs.saltstack.com/en/latest/)
* [Saltstack walkthrough](http://docs.saltstack.com/en/latest/topics/tutorials/walkthrough.html)
* [Saltstack formulas on GitHub](https://github.com/saltstack-formulas)
* [Beginner's Tutorial](https://blog.talpor.com/2014/07/saltstack-beginners-tutorial/)
* [A Taste of Salt: Like Puppet, But Less Frustrating](http://blog.smartbear.com/devops/a-taste-of-salt-like-puppet-except-it-doesnt-suck/)


<a name="how-to-list-current-minions"></a>
# How to list current minions

```
[jtunison@es-ppsaltm01 ~]$ sudo salt-key -L
Accepted Keys:
DevOps01
DevOps02
adam_laptop
bamboo-agent-2.novalocal
bamboo-large-agent.novalocal
es-c1web01.dal.securustech.net
es-c2web01.dal.securustech.net
es-ppngweb01.pp.securustech.net
es-ppsear01-vhost19.pp.securustech.net
es-ppthrpt01
es-ppwla01
psl-devapi01.lab.securustech.net
psl-devcies01
psl-devcies02.lab.securustech.net
psl-devcies03.lab.securustech.net
psl-devcimdb01
psl-devcimdb02
psl-devcimdb03
psl-devcing01
psl-devcing02.lab.securustech.net
psl-devcing03.lab.securustech.net
psl-devcing04.lab.securustech.net
psl-devcompile02.lab.securustech.net
psl-devcompile03.lab.securustech.net
psl-devcompile04.lab.securustech.net
psl-devcompile05.lab.securustech.net
psl-devnexus01.lab.securustech.net
psl-qac1web01.lab.securustech.net
psl-qac2web01.lab.securustech.net
psl-qangscpweb01.lab.securustech.net
Denied Keys:
Unaccepted Keys:
Rejected Keys:

```

<a name="how-to-salt-a-new-machine"></a>
# How to salt a new machine

## without a master
TBD

## via salt-ssh
TBD

## via a salt master
1. ssh into the new machine

	```
	Johns-MacBook-Pro:saltstack jtunison$ ssh psl-devcing04
	The authenticity of host 'psl-devcing04 (10.6.246.169)' can't be established.
	RSA key fingerprint is SHA256:mpyNdpLQS27kYSyStt9nDFLNA9gWQo35Xj7OrvMUJtU.
	Are you sure you want to continue connecting (yes/no)? yes
	Warning: Permanently added 'psl-devcing04,10.6.246.169' (RSA) to the list of known hosts.
	********************      NOTICE TO USERS      **************************
	*                                                                       *
	*  THIS IS A PRIVATE COMPUTER SYSTEM. It is for authorized use only.    *
	*  Users (authorized or unauthorized) have no explicit or implicit      *
	*  expectation of privacy.                                              *
	*  Any or all uses of this system and all files on this system may      *
	*  be intercepted, monitored, recorded, copied, audited, inspected"     *
	*  and disclosed to authorized site and law enforcement personnel"      *
	*  as well as authorized officials of other agencies, both domestic     *
	*  and foreign.                                                         *
	*  By using this system, the user consents to such interception"        *
	*  monitoring, recording, copying, auditing, inspection, and            *
	*  disclosure at the discretion of authorized site personnel.           *
	*  Unauthorized or improper use of this system may result in            *
	*  administrative disciplinary action and civil and criminal penalties. *
	*  By continuing to use this system you indicate your awareness of and  *
	*  consent to these terms and conditions of use.                        *
	*  LOG OFF IMMEDIATELY if you do not agree to the conditions stated     *
	*  in this warning.                                                     *
	*                                                                       *
	*************************************************************************
	Password: 
	Password will expire in 9 days
	Created home directory
	[jtunison@psl-devcing04 ~]$ 
	```
2. Modify /etc/hosts to add an entry to point to the salt master

	```
	[root@psl-devcing04 ~]# cat /etc/hosts
	127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
	::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
	10.70.240.59 salt
	
	```

3. Enable the securus extras repo and the securus EPEL repo by settings enabled=1 in /etc/yum.repos.d/securus.repo. (Both are disabled by default on new Securus builds.)

	```
	[root@psl-devcing04 ~]# cat /etc/yum.repos.d/securus.repo 
	## Base Linux (RHEL/CentOS) Repo
	[base]
	name=CentOS Base
	baseurl=http://psl-admtools01/CentOS/$releasever/7.1/$basearch/
	enabled=1
	gpgcheck=1
	
	## Extras - Extra apps that are not Securus products
	[extras]
	name=Third Party Extras
	baseurl=http://psl-admtools01/repos/extras/$releasever/
	enabled=1
	gpgcheck=0
	
	## Securus SCP and other related apps.
	[securus]
	name=Securus Internal
	baseurl=http://psl-admtools01/repos/securus/$releasever/
	enabled=1
	gpgcheck=0
	
	## Securus SCP and other related apps.
	[epel]
	name=EPEL
	baseurl=http://psl-admtools01/repos/epel/epel-$releasever-$basearch
	enabled=1
	gpgcheck=0
	
	```

4. Install the salt-minion

	```
	[root@psl-devcing04 ~]# yum install salt-minion
	Loaded plugins: fastestmirror, langpacks
	base                                                                                                    | 2.9 kB  00:00:00     
	epel                                                                                                    | 2.9 kB  00:00:00     
	extras                                                                                                  | 2.9 kB  00:00:00     
	securus                                                                                                 | 3.3 kB  00:00:00     
	extras/7/primary_db                                                                                     | 165 kB  00:00:00     
	Loading mirror speeds from cached hostfile
	Resolving Dependencies
	--> Running transaction check
	---> Package salt-minion.noarch 0:2014.7.1-1.el7 will be installed
	--> Processing Dependency: salt = 2014.7.1-1.el7 for package: salt-minion-2014.7.1-1.el7.noarch
	--> Running transaction check
	---> Package salt.noarch 0:2014.7.1-1.el7 will be installed
	--> Processing Dependency: sshpass for package: salt-2014.7.1-1.el7.noarch
	--> Processing Dependency: python-zmq for package: salt-2014.7.1-1.el7.noarch
	--> Processing Dependency: python-requests for package: salt-2014.7.1-1.el7.noarch
	--> Processing Dependency: python-msgpack for package: salt-2014.7.1-1.el7.noarch
	--> Processing Dependency: python-jinja2 for package: salt-2014.7.1-1.el7.noarch
	--> Processing Dependency: python-crypto for package: salt-2014.7.1-1.el7.noarch
	--> Processing Dependency: m2crypto for package: salt-2014.7.1-1.el7.noarch
	--> Processing Dependency: PyYAML for package: salt-2014.7.1-1.el7.noarch
	--> Running transaction check
	---> Package PyYAML.x86_64 0:3.10-11.el7 will be installed
	--> Processing Dependency: libyaml-0.so.2()(64bit) for package: PyYAML-3.10-11.el7.x86_64
	---> Package m2crypto.x86_64 0:0.21.1-15.el7 will be installed
	---> Package python-crypto.x86_64 0:2.6.1-1.el7 will be installed
	---> Package python-jinja2.noarch 0:2.7.2-2.el7 will be installed
	--> Processing Dependency: python-babel >= 0.8 for package: python-jinja2-2.7.2-2.el7.noarch
	--> Processing Dependency: python-markupsafe for package: python-jinja2-2.7.2-2.el7.noarch
	---> Package python-msgpack.x86_64 0:0.4.4-2.el7 will be installed
	---> Package python-requests.noarch 0:1.1.0-8.el7 will be installed
	--> Processing Dependency: python-urllib3 for package: python-requests-1.1.0-8.el7.noarch
	---> Package python-zmq.x86_64 0:14.3.1-1.el7 will be installed
	--> Processing Dependency: libzmq.so.3()(64bit) for package: python-zmq-14.3.1-1.el7.x86_64
	---> Package sshpass.x86_64 0:1.05-5.el7 will be installed
	--> Running transaction check
	---> Package libyaml.x86_64 0:0.1.4-11.el7_0 will be installed
	---> Package python-babel.noarch 0:0.9.6-8.el7 will be installed
	---> Package python-markupsafe.x86_64 0:0.11-10.el7 will be installed
	---> Package python-urllib3.noarch 0:1.5-8.el7 will be installed
	---> Package zeromq3.x86_64 0:3.2.4-1.el7 will be installed
	--> Processing Dependency: libpgm-5.2.so.0()(64bit) for package: zeromq3-3.2.4-1.el7.x86_64
	--> Running transaction check
	---> Package openpgm.x86_64 0:5.2.122-2.el7 will be installed
	--> Finished Dependency Resolution
	
	Dependencies Resolved
	
	===============================================================================================================================
	 Package                             Arch                     Version                             Repository              Size
	===============================================================================================================================
	Installing:
	 salt-minion                         noarch                   2014.7.1-1.el7                      epel                    23 k
	Installing for dependencies:
	 PyYAML                              x86_64                   3.10-11.el7                         base                   153 k
	 libyaml                             x86_64                   0.1.4-11.el7_0                      base                    55 k
	 m2crypto                            x86_64                   0.21.1-15.el7                       base                   428 k
	 openpgm                             x86_64                   5.2.122-2.el7                       epel                   171 k
	 python-babel                        noarch                   0.9.6-8.el7                         base                   1.4 M
	 python-crypto                       x86_64                   2.6.1-1.el7                         epel                   469 k
	 python-jinja2                       noarch                   2.7.2-2.el7                         base                   515 k
	 python-markupsafe                   x86_64                   0.11-10.el7                         base                    25 k
	 python-msgpack                      x86_64                   0.4.4-2.el7                         epel                    71 k
	 python-requests                     noarch                   1.1.0-8.el7                         base                    70 k
	 python-urllib3                      noarch                   1.5-8.el7                           base                    41 k
	 python-zmq                          x86_64                   14.3.1-1.el7                        epel                   468 k
	 salt                                noarch                   2014.7.1-1.el7                      epel                   3.2 M
	 sshpass                             x86_64                   1.05-5.el7                          epel                    21 k
	 zeromq3                             x86_64                   3.2.4-1.el7                         epel                   339 k
	
	Transaction Summary
	===============================================================================================================================
	Install  1 Package (+15 Dependent packages)
	
	Total download size: 7.4 M
	Installed size: 30 M
	Is this ok [y/d/N]: Y
	Downloading packages:
	(1/16): libyaml-0.1.4-11.el7_0.x86_64.rpm                                                               |  55 kB  00:00:00     
	(2/16): PyYAML-3.10-11.el7.x86_64.rpm                                                                   | 153 kB  00:00:00     
	(3/16): m2crypto-0.21.1-15.el7.x86_64.rpm                                                               | 428 kB  00:00:00     
	(4/16): python-jinja2-2.7.2-2.el7.noarch.rpm                                                            | 515 kB  00:00:00     
	(5/16): python-babel-0.9.6-8.el7.noarch.rpm                                                             | 1.4 MB  00:00:00     
	(6/16): python-markupsafe-0.11-10.el7.x86_64.rpm                                                        |  25 kB  00:00:00     
	(7/16): openpgm-5.2.122-2.el7.x86_64.rpm                                                                | 171 kB  00:00:00     
	(8/16): python-crypto-2.6.1-1.el7.x86_64.rpm                                                            | 469 kB  00:00:00     
	(9/16): python-msgpack-0.4.4-2.el7.x86_64.rpm                                                           |  71 kB  00:00:00     
	(10/16): python-zmq-14.3.1-1.el7.x86_64.rpm                                                             | 468 kB  00:00:00     
	(11/16): salt-minion-2014.7.1-1.el7.noarch.rpm                                                          |  23 kB  00:00:00     
	(12/16): sshpass-1.05-5.el7.x86_64.rpm                                                                  |  21 kB  00:00:00     
	(13/16): zeromq3-3.2.4-1.el7.x86_64.rpm                                                                 | 339 kB  00:00:00     
	(14/16): salt-2014.7.1-1.el7.noarch.rpm                                                                 | 3.2 MB  00:00:00     
	(15/16): python-requests-1.1.0-8.el7.noarch.rpm                                                         |  70 kB  00:00:00     
	(16/16): python-urllib3-1.5-8.el7.noarch.rpm                                                            |  41 kB  00:00:00     
	-------------------------------------------------------------------------------------------------------------------------------
	Total                                                                                           11 MB/s | 7.4 MB  00:00:00     
	Running transaction check
	Running transaction test
	Transaction test succeeded
	Running transaction
	  Installing : sshpass-1.05-5.el7.x86_64                                                                                  1/16 
	  Installing : python-urllib3-1.5-8.el7.noarch                                                                            2/16 
	  Installing : python-requests-1.1.0-8.el7.noarch                                                                         3/16 
	  Installing : python-crypto-2.6.1-1.el7.x86_64                                                                           4/16 
	  Installing : openpgm-5.2.122-2.el7.x86_64                                                                               5/16 
	  Installing : zeromq3-3.2.4-1.el7.x86_64                                                                                 6/16 
	  Installing : python-zmq-14.3.1-1.el7.x86_64                                                                             7/16 
	  Installing : python-babel-0.9.6-8.el7.noarch                                                                            8/16 
	  Installing : python-msgpack-0.4.4-2.el7.x86_64                                                                          9/16 
	  Installing : python-markupsafe-0.11-10.el7.x86_64                                                                      10/16 
	  Installing : python-jinja2-2.7.2-2.el7.noarch                                                                          11/16 
	  Installing : m2crypto-0.21.1-15.el7.x86_64                                                                             12/16 
	  Installing : libyaml-0.1.4-11.el7_0.x86_64                                                                             13/16 
	  Installing : PyYAML-3.10-11.el7.x86_64                                                                                 14/16 
	  Installing : salt-2014.7.1-1.el7.noarch                                                                                15/16 
	  Installing : salt-minion-2014.7.1-1.el7.noarch                                                                         16/16 
	  Verifying  : libyaml-0.1.4-11.el7_0.x86_64                                                                              1/16 
	  Verifying  : python-jinja2-2.7.2-2.el7.noarch                                                                           2/16 
	  Verifying  : m2crypto-0.21.1-15.el7.x86_64                                                                              3/16 
	  Verifying  : python-markupsafe-0.11-10.el7.x86_64                                                                       4/16 
	  Verifying  : python-msgpack-0.4.4-2.el7.x86_64                                                                          5/16 
	  Verifying  : python-babel-0.9.6-8.el7.noarch                                                                            6/16 
	  Verifying  : PyYAML-3.10-11.el7.x86_64                                                                                  7/16 
	  Verifying  : openpgm-5.2.122-2.el7.x86_64                                                                               8/16 
	  Verifying  : salt-minion-2014.7.1-1.el7.noarch                                                                          9/16 
	  Verifying  : python-crypto-2.6.1-1.el7.x86_64                                                                          10/16 
	  Verifying  : python-urllib3-1.5-8.el7.noarch                                                                           11/16 
	  Verifying  : salt-2014.7.1-1.el7.noarch                                                                                12/16 
	  Verifying  : python-requests-1.1.0-8.el7.noarch                                                                        13/16 
	  Verifying  : python-zmq-14.3.1-1.el7.x86_64                                                                            14/16 
	  Verifying  : zeromq3-3.2.4-1.el7.x86_64                                                                                15/16 
	  Verifying  : sshpass-1.05-5.el7.x86_64                                                                                 16/16 
	
	Installed:
	  salt-minion.noarch 0:2014.7.1-1.el7                                                                                          
	
	Dependency Installed:
	  PyYAML.x86_64 0:3.10-11.el7              libyaml.x86_64 0:0.1.4-11.el7_0            m2crypto.x86_64 0:0.21.1-15.el7        
	  openpgm.x86_64 0:5.2.122-2.el7           python-babel.noarch 0:0.9.6-8.el7          python-crypto.x86_64 0:2.6.1-1.el7     
	  python-jinja2.noarch 0:2.7.2-2.el7       python-markupsafe.x86_64 0:0.11-10.el7     python-msgpack.x86_64 0:0.4.4-2.el7    
	  python-requests.noarch 0:1.1.0-8.el7     python-urllib3.noarch 0:1.5-8.el7          python-zmq.x86_64 0:14.3.1-1.el7       
	  salt.noarch 0:2014.7.1-1.el7             sshpass.x86_64 0:1.05-5.el7                zeromq3.x86_64 0:3.2.4-1.el7           
	
	Complete!
	
	```

5.  Start the salt-minion!

	```
	[root@psl-devcing04 ~]# systemctl start salt-minion 
	```

5.  After the salt-minion is up and running, you might want to check to see if anything interesting has happened:

	```
	[root@psl-devcing04 ~]# less +F /var/log/salt/minion 
	```

<a name="how-to-run-salt-states-from-the-salt-master"></a>
# How to run salt states from the salt master

1.  ssh to the salt master

	```
	ssh 10.70.240.59
	```

2. run salt with the box and the desired state.  For example:

	```
	[jtunison@es-ppsaltm01 ~]$ sudo salt 'psl-devcies03.lab.securustech.net' state.sls nextgen.elasticsearch
	```

