default['collectd']['fqdn_lookup'] = 'false'

default['set_fqdn'] = "*.#{node.chef_environment}.dealermatch.biz"

default['zabbix']['agent']['servers'] = ['ip-10-39-89-65.ec2.internal']
default['zabbix']['agent']['servers_active'] = ['ip-10-39-89-65.ec2.internal']

default['base']['enable-monitoring'] = true
