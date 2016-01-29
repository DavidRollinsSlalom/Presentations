# https://github.com/creationix/nvm

nodejs-and-npm-prereqs:
  pkg.installed:
    - pkgs:
      - gcc-c++
      - freetype   # for phantomjs
      - fontconfig # for phantomjs

install nvm:
  cmd.script:
    - source: https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh
    - shell: /bin/bash
    - user: bamboo
    - group: bamboo
    - env:
      - NVM_DIR: '/opt/bamboo/nvm'

install node versions:
  cmd.run:
    - shell: /bin/bash
    - user: bamboo
    - group: bamboo
    - name: |
        . /opt/bamboo/nvm/nvm.sh
        # http://stackoverflow.com/questions/26476744/nvm-ls-remote-command-results-in-n-a
        export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist
        nvm install 5.3.0
        npm install -g json-lint
        npm install -g bower
        npm install -g grunt-cli
        npm install -g grunt-sass
        npm install -g swagger-tools
        npm install -g karma
        npm install -g karma-jasmine-jquery
        npm install -g phantomjs
        npm install -g protractor
        npm install -g yaml2json
        npm install -g jsonlint # used in es-templates build to verify the templates are valid JSON
        nvm install 0.12.7 --reinstall-packages-from=5.3.0
        nvm alias default 5.3.0

