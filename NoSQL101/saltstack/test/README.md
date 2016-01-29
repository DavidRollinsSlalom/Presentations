This vagrant box lets you test Salt scripts using a masterless setup.  Very handy for testing prior to deployment!

# Howto

* (optional) vagrant destroy -f
* vagrant up
* vagrant ssh -c "sudo salt-call --local state.sls -l debug <salt-formula>"

For instance: 
$ vagrant ssh -c "sudo salt-call --local state.sls -l debug bamboo.agent"



