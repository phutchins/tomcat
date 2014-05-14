node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'staging'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d2tyyywupxeit9.cloudfront.net'

node.normal['corndog']['mongodb']['host_port_1'] = 'cde-staging.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['database'] = 'cde_staging'

node.normal['corndog']['solr']['path'] = '/solr/2ffb7bfb331'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
