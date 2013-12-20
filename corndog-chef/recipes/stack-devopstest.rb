# This file includes all attributes that apply only to the devopstest stack

Chef::Log.info("Chef Attributes: #{node['opsworks'].inspect}")

# Environmental Variables
profile = 'test'
rails_env = 'production'
stack = 'devopstest'
redis_port = "6379"
redis_uri_override = nil
#mongodb_host_port_1 = "mongo-devopstest.dealermatch.biz:27017"
mongodb_host_port_1 = "cde-prod2.m0.mongolayer.com:27017"
mongodb_host_port_2 = "cde-prod2.m1.mongolayer.com:27017"
mongodb_host_port_3 = nil
mongodb_database = "cde_production"
mongodb_username = "cdx_user"
mongodb_password = "carsrstillc00l"
mongodb_options_1 = "consistency: :strong"
mongodb_options_2 = nil
mongodb_options_3 = nil
cloudfront_site = "https://devopstest.dealermatch.biz"
cloudfront_asset_hosts = "https://d3vxuqwloblfjh.cloudfront.net"

# Assign environmentals to node
node.normal['corndog']['profile'] = profile
node.normal['corndog']['rails_env'] = rails_env
node.normal['corndog']['stack'] = stack
# Not sure if we need to set this here (should already be set in OW app deploy configuration)
node.normal['deploy']['Corndog_APP']['rails_env'] = profile
node.normal['corndog']['redis']['uri'] = redis_uri_override
node.normal['corndog']['redis']['port'] = "6379"
node.normal['corndog']['mongodb']['host_port_1'] = mongodb_host_port_1
node.normal['corndog']['mongodb']['host_port_2'] = mongodb_host_port_2
node.normal['corndog']['mongodb']['host_port_3'] = mongodb_host_port_3
node.normal['corndog']['mongodb']['database'] = mongodb_database
node.normal['corndog']['mongodb']['username'] = mongodb_username
node.normal['corndog']['mongodb']['password'] = mongodb_password
node.normal['corndog']['mongodb']['options_1'] = mongodb_options_1
node.normal['corndog']['mongodb']['options_2'] = mongodb_options_2
node.normal['corndog']['mongodb']['options_3'] = mongodb_options_3
node.normal['corndog']['cloudfront']['site'] = cloudfront_site
node.normal['corndog']['cloudfront']['asset_hosts'] = cloudfront_asset_hosts

node.normal['corndog']['solr']['host'] = "index.websolr.com"
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = "/solr/90a76be5e41"
node.normal['corndog']['solr']['master_host'] = "index.websolr.com"
node.normal['corndog']['solr']['master_port'] = 80
node.normal['corndog']['solr']['master_path'] = "/solr/2ffb7bfb331"
node.normal['corndog']['solr']['log_level'] = "WARNING"

run_context.include_recipe "corndog-chef::profile-#{profile}"
