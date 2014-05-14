node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'qa_etl'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['cloudfront']['asset_hosts'] = "https://qa-etl.dealermatch.biz"

mongodb_host_port_1 = 'mongo3.dealermatch.biz:27017'
mongodb_database = 'cde_production'

node.normal['corndog']['mongodb']['host_port_1'] = mongodb_host_port_1
node.normal['corndog']['mongodb']['database'] = mongodb_database

node.normal['corndog']['mongodb_archive']['host_port_1'] = mongodb_host_port_1
node.normal['corndog']['mongodb_archive']['database'] = mongodb_database

node.normal['corndog']['solr']['path'] = '/solr/dc2f508b356'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
