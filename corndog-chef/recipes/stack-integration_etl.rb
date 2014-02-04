node.normal['corndog']['stack'] = 'integration_etl'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'charlotte.mongohq.com:10033'
node.normal['corndog']['mongodb']['host_port_2'] = nil
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_etl_integration'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['solr']['host'] = '23.22.128.7'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/2f9b22f97f1'
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['marketing']['enabled'] = false

node.normal['corndog']['aws']['image_bucket'] = 'cde-integration-etl-images'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
