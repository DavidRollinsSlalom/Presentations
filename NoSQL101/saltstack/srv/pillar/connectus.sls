#!py
import salt.client as s_client
import salt.config as s_config

# pylint: enable=import-error

	# Import salt libs
#from salt.exceptions import SaltInvocationError, CommandExecutionError


def proc_fetcher():
	the_salt_config_dictionary = s_config.master_config('/etc/salt/master')
	exeThing= s_client.LocalClient(mopts=the_salt_config_dictionary)
	this_Min_ID = __grains__['id'] #get the current minions id thats running this pillar.
	get_connectus_proc = exeThing.cmd(this_Min_ID,'ps.pgrep',['httpd'],kwarg={'full':'true'}) # returns the pid's if the proc is runn$
	return get_connectus_proc

def run():
	checker = proc_fetcher()
	#newJobFile = open('/opt/data/dammit.yml', 'w+')
	#newJobFile.write(str(checker[__grains__['id']]))
	#newJobFile.close()
	if len(checker):
		if __grains__['id'] in checker:
			if type(checker[__grains__['id']]) is list: #and type(checker[__grains__['id']][0]) is int:
				return {'connectus':True}
			else:
				return {'connectus':'ERROR, THE DICT CONTAINS THE MINION ID BUT NOT A LIST'}
		else:
			return {'connectus':'ERROR, THE ID WASNT IN THE DICT'}
	else:
		return {'connectus':False}
