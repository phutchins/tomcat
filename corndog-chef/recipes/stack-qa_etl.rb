node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'qa_etl'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['mongodb']['host_port_1'] = 'mongo3.dealermatch.biz:27017'
node.normal['corndog']['mongodb']['database'] = 'cde_production'

nocd.normal['corndog']['cloudfront']['asset_hosts'] = "https://qa-etl.dealermatch.biz"

node.normal['corndog']['solr']['path'] = '/solr/eaa64a9f345'
node.normal['corndog']['solr']['master_path'] = '/solr/dc2f508b356'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
