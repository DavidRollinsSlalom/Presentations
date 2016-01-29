# installation:  https://confluence.atlassian.com/bamboo/bamboo-remote-agent-installation-guide-289276832.html
# options:  https://confluence.atlassian.com/bamboo/additional-remote-agent-options-436044733.html
# capabilities:  https://confluence.atlassian.com/bamboo/configuring-remote-agent-capabilities-using-bamboo-capabilities-properties-289276849.html
# best practices:  https://confluence.atlassian.com/bamboo/bamboo-best-practice-using-agents-414189352.html#BambooBestPractice-UsingAgents-Usingremoteagents

include:
   - bamboo.common

/etc/hosts:
  file.managed:
    - source: salt://bamboo/files/hosts
    - user: root
    - group: root
    - mode: 644
    - template: jinja

bamboo-agent-download:
  file.managed:
    - name: /opt/bamboo/agent-installer-5.9.7.jar
    - source: http://es-compile01.emcent.scn.securustech.net/agentServer/agentInstaller/atlassian-bamboo-agent-installer-5.9.7.jar
    - source_hash: md5=80cfcc6fd74318bfae3db82b07159cd7
    - user: bamboo
    - group: bamboo
    - mode: 644

/opt/bamboo/agent-installer-current.jar:
  file.symlink:
    - target: /opt/bamboo/agent-installer-5.9.7.jar

{%- for agentNumber in range(1,5) %}

/etc/systemd/system/bamboo-agent-{{agentNumber}}.service:
  file.managed:
    - source: salt://bamboo/files/bamboo-agent.service
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        agentNumber: {{agentNumber}}

/opt/bamboo/agent-{{agentNumber}}/bin:
  file.directory:
    - user: bamboo
    - group: bamboo
    - mode: 744
    - makedirs: True

/opt/bamboo/agent-{{agentNumber}}/bin/bamboo-capabilities.properties:
  file.managed:
    - source: salt://bamboo/files/bamboo-capabilities.properties
    - user: bamboo
    - group: bamboo
    - mode: 644

bamboo-agent-service-{{agentNumber}}:
  service.running:
    - name: bamboo-agent-{{agentNumber}}
    - enable: True

{%- endfor %}

