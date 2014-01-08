default['graphite']['server_address'] = 'graphs.dealermatch.biz'
default['collectd']['fqdn_lookup'] = 'false'
default['collectd']['graphite_prefix'] = "hosts.#{node.chef_environment}"
default['collectd']['logging_enabled'] = true

# Default settings for plugins
default['collectd']['plugin-ntpd'] = false
default['collectd']['plugin-swap'] = false

# Newrelic attributes
default['newrelic']['repository_key'] = "548C16BF"
default['newrelic']['license_key'] = "6051b4e0dee1077fa709d674410e8ebc66489676"
default['newrelic']['app_name'] = "default"
default['newrelic']['loglevel'] = "info"

# Logstash attributes
override['logstash']['user'] = 'root'
override['logstash']['group'] = 'root'
#override['logstash']['supervisor_gid'] = 'root'
