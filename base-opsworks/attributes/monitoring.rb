default['graphite']['server_address'] = 'graphs.dealermatch.biz'
default['collectd']['fqdn_lookup'] = 'false'
node_name = node[:fqdn].slice ".localdomain" || node[:fqdn]
default['collectd']['graphite_prefix'] = "#{node[:opsworks][:stack][:name]}.#{node_name}"
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
