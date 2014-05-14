node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'qa'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d32lfm0jr6byac.cloudfront.net'

mongodb_host_port_1 = 'mongo-qa.dealermatch.biz:27017'
mongodb_database = 'cde_production'

node.normal['corndog']['mongodb']['host_port_1'] = mongodb_host_port_1
node.normal['corndog']['mongodb']['database'] = mongodb_database

node.normal['corndog']['mongodb_archive']['host_port_1'] = mongodb_host_port_1
node.normal['corndog']['mongodb_archive']['database'] = mongodb_database

node.normal['corndog']['solr']['path'] = '/solr/e3cb33a92d8'

node.normal['corndog']['action_mailer']['default_url_options_host'] = 'qa.dealermatch.biz'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"

