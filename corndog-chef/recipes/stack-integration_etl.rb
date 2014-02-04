node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'integration_etl'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['mongodb']['host_port_1'] = 'charlotte.mongohq.com:10033'
node.normal['corndog']['mongodb']['database'] = 'cde_etl_integration'

node.normal['corndog']['solr']['path'] = '/solr/2f9b22f97f1'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
