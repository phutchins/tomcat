# Should combine both of these into one. They are both used in different places.
node.default['corndog']['node_type'] = 'rails_app'
node.default['corndog']['host_role'] = 'rails_app'

include_recipe 'base-opsworks'
include_recipe 'base-opsworks::monitoring-app'
