node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'devopstest'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d2p6u70htaba93.cloudfront.net'

node.normal['corndog']['mongodb']['host_port_1'] = 'mongodb-devopstest-1.dealermatch.biz:27017'

node.normal['corndog']['mongodb']['database'] = 'cde_production'

node.normal['corndog']['solr']['path'] = '/solr/bdada2584a2'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
