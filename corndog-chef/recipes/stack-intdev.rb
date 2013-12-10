# This file includes all attributes that apply only to the devopstest stack

# Environmental Variables
profile = 'development'
stack = 'intdev'
redis_port = "6379"
redis_uri_override = nil
mongodb_host_port_1 = "localhost:27017"
mongodb_host_port_2 = nil
mongodb_host_port_3 = nil
mongodb_database = "cde_development"
mongodb_username = "cdx_ro"
mongodb_password = "carsrstillc00l"
mongodb_options_1 = "consistency: :strong"
mongodb_options_2 = nil
mongodb_options_3 = nil
mongodb_session_options = "identity_map_enabled: true"

# Assign environmentals to node
node.normal['corndog']['profile'] = profile
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
node.normal['corndog']['mongodb']['session_options'] = mongodb_session_options

include_recipe "corndog-chef::profile-#{profile}"
