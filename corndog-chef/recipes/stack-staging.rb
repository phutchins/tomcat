# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'staging'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'cde-staging.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = nil
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_staging'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['mongodb']['identity_map_enabled'] = 'true'
node.normal['corndog']['mongodb']['consistency'] = ':strong'
node.normal['corndog']['cloudfront']['site'] = 'https://devopstest.dealermatch.biz'
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d37di6rf5nv9f5.cloudfront.net'
node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/90a76be5e41'
node.normal['corndog']['solr']['master_host'] = 'index.websolr.com'
node.normal['corndog']['solr']['master_port'] = 80
node.normal['corndog']['solr']['master_path'] = '/solr/2ffb7bfb331'
node.normal['corndog']['solr']['log_level'] = 'WARNING'
# Commenting out for testing
#node.normal['corndog']['marketing']['url'] = 'http://www3.dealermatch.com'
node.normal['corndog']['marketing']['url'] = nil

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
