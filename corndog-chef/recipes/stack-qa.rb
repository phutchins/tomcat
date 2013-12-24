# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'qa'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'c0.cde-qa.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = nil
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_production'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['mongodb']['identity_map_enabled'] = 'true'
node.normal['corndog']['mongodb']['consistency'] = ':strong'
node.normal['corndog']['cloudfront']['site'] = 'https://qa.dealermatch.biz'
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://dorg1gxa8jgh1.cloudfront.net'
node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/e3cb33a92d8'
node.normal['corndog']['solr']['master_host'] = nil
node.normal['corndog']['solr']['master_port'] = nil
node.normal['corndog']['solr']['master_path'] = nil
node.normal['corndog']['solr']['log_level'] = 'WARNING'
# Commenting out for testing
#node.normal['corndog']['marketing']['url'] = 'http://www3.dealermatch.com'

run_context.include_recipe "corndog-chef::profile-production"
