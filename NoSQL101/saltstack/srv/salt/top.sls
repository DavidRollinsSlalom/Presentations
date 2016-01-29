base:
  #'*':
    #- copy_my_files
    #- machine_bootup
    #- newmachine
  nextgen:
    - nextgen.web

  # NextGen CI environments
  'psl-devcing0*':
    - nextgen.webworker
    - nextgen.bamboo-support
    - nextgen.dev-support
  'psl-devcies*':
    - nextgen.elasticsearch
  'psl-devcimdb*':
    - nextgen.mongodb

  # NextGen Vagrant box for local development
  nextgen-vagrant:
    - nextgen.webworker
    - nextgen.dev-support
    - nextgen.elasticsearch
    - nextgen.mongodb

