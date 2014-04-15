# Should combine both of these into one. They are both used in different places.
node.default['corndog']['node_type'] = 'resque'
node.default['corndog']['host_role'] = 'resque'

include_recipe 'base-opsworks'
include_recipe 'base-opsworks::monitoring-resque'
