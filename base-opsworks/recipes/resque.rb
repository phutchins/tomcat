node.default['corndog']['node_type'] = 'resque'

include_recipe 'base-opsworks::monitoring-logstash-resque'
include_recipe 'base-opsworks::default'
