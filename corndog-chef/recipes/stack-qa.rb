# This file includes all attributes that apply only to the devopstest stack

# Environmental Variables
profile = 'production'
rails_env = 'production'
stack = 'qa'
redis_port = "6379"
redis_uri_override = nil
#mongodb_host_port_1 = "mongo-devopstest.dealermatch.biz:27017"
mongodb_host_port_1 = "cde-prod2.m0.mongolayer.com:27017"
profile = 'test'
stack = 'devopstest'
redis_port = "6379"
redis_uri_override = nil
mongodb_host_port_1 = "mongo-devopstest.dealermatch.biz:27017"
mongodb_host_port_2 = nil
mongodb_host_port_3 = nil
mongodb_database = "cde_production"
mongodb_username = "cdx_ro"
mongodb_password = "carsrstillc00l"
mongodb_options_1 = "consistency: :strong"
mongodb_options_2 = "identity_map_enabled: true"
mongodb_options_3 = nil
cloudfront_site = "https://qa.dealermatch.biz"
cloudfront_asset_hosts = "https://d3vxuqwloblfjh.cloudfront.net"

# Assign environmentals to node
node.normal['corndog']['profile'] = profile
node.normal['corndog']['stack'] = stack
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

include_recipe "corndog-chef::profile-#{profile}"
