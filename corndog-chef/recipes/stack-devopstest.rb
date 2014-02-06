node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'devopstest'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d5a12sbnyk1s7.cloudfront.net'

node.normal['corndog']['mongodb']['host_port_1'] = 'cde-prod2.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = 'cde-prod2.m1.mongolayer.com:27017'
node.normal['corndog']['mongodb']['database'] = 'cde_production'

node.normal['corndog']['solr']['path'] = '/solr/8c328dc5a19'
node.normal['corndog']['solr']['master_path'] = '/solr/bdada2584a2'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
