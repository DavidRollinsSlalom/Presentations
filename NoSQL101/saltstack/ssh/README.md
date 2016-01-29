This vagrant box lets you use salt-ssh to deploy salt formulas without using a salt master.

# Howto

* vagrant destroy -f
* vagrant up
* vagrant ssh 

sudo salt-ssh es-compile02 state.sls bamboo.agent

