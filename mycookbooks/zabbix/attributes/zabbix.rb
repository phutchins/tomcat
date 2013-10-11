default[:zabbix][:version] = '2.0.5'
default[:zabbix][:install_on_envs] = [ 'production','qa','demo','staging','integration','devopstest' ]
default[:zabbix][:install_on_node] = [ 'app','app_master','util','db-master','db-slave','solo']
default[:zabbix][:log_debug_level] = 3
default[:zabbix][:server] = 'monitor.dealermatch.biz'
default[:zabbix][:server_active] = 'monitor.dealermatch.biz'
default[:zabbix][:server_port] = 10051
default[:zabbix][:listen_port] = 10050
default[:zabbix][:start_agents] = 4
default[:zabbix][:timeout] = 15
default[:zabbix][:prefix] = '/usr/local'


