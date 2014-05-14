node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'integration_etl'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['cloudfront']['asset_hosts'] = "https://integration-etl.dealermatch.biz"

mongodb_host_port_1 = 'charlotte.mongohq.com:10033'
mongodb_database = 'cde_etl_integration'

node.normal['corndog']['mongodb']['host_port_1'] = mongodb_host_port_1
node.normal['corndog']['mongodb']['database'] = mongodb_database

node.normal['corndog']['mongodb_archive']['host_port_1'] = mongodb_host_port_1
node.normal['corndog']['mongodb_archive']['database'] = mongodb_database


node.normal['corndog']['solr']['path'] = '/solr/2f9b22f97f1'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
