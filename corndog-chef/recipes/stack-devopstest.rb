node.normal['corndog']['stack'] = 'devopstest'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'cde-prod2.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = 'cde-prod2.m1.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_production'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['mongodb']['identity_map_enabled'] = 'true'
node.normal['corndog']['mongodb']['consistency'] = ':strong'
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d2tb02q5zn0zzy.cloudfront.net'
node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/8c328dc5a19'
node.normal['corndog']['solr']['master_host'] = 'index.websolr.com'
node.normal['corndog']['solr']['master_port'] = 80
node.normal['corndog']['solr']['master_path'] = '/solr/bdada2584a2'
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['marketing']['enabled'] = false
node.normal['corndog']['marketing']['url'] = 'http://www3.dealermatch.com'

node.normal['corndog']['aws']['image_bucket'] = 'cde-images'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
