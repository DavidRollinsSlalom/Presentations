Salt formulas to bring up bamboo server and agent.

# To test bamboo agent install:

$ vagrant destroy -f && vagrant up; vagrant ssh -c "sudo salt-call --local state.sls -l debug bamboo.agent"

# To test bamboo server install

$ vagrant destroy -f && vagrant up; vagrant ssh -c "sudo salt-call --local state.sls -l debug bamboo.server.init"
