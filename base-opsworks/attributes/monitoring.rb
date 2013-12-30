default['graphite']['server_address'] = 'graphs.dealermatch.biz'
default['collectd']['fqdn_lookup'] = 'false'
default['collectd']['graphite_prefix'] = "hosts.#{node.chef_environment}"
default['collectd']['logging_enabled'] = true

# Default settings for plugins
default['collectd']['plugin-ntpd'] = false
default['collectd']['plugin-swap'] = false

# Newrelic attributes
default['newrelic']['repository_key'] = "548C16BF"
