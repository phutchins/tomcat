# This file includes all logic for testing like environments

profile = 'production'
rails_env = 'production'
node.normal['corndog']['profile'] = profile

# Retrieve attributes from node object
# Required attributes (add some logic here to fail if not assigned)
mongodb_host_ports = node['corndog']['mongodb']['host_ports']
mongodb_database = node['corndog']['mongodb']['database']
mongodb_username = node['corndog']['mongodb']['username']
mongodb_password = node['corndog']['mongodb']['password']
redis_uri = node['corndog']['redis']['uri']

# Additional attributes
mongodb_host_port_2 ||= node['corndog']['mongodb']['host_port_2']
mongodb_host_port_3 ||= node['corndog']['mongodb']['host_port_3']
mongodb_option_1 ||= node['corndog']['mongodb']['option_1']
mongodb_option_2 ||= node['corndog']['mongodb']['option_2']
mongodb_option_3 ||= node['corndog']['mongodb']['option_3']
cloudfront_host ||= node['corndog']['cloudfront']['host']
cloudfront_asset_hosts ||= node['corndog']['cloudfront']['asset_hosts']

# Attributes from the OpsWorks Environment
redis_uri = 'redis://'
node['opsworks']['layers']['redis']['instances'].each do |instance|
  Chef::Log.info("Adding instance '#{instance[0]}' to Redis URI with hostname '#{instance[1]['public_dns_name']}'")
  redis_uri << "#{instance[1]['public_dns_name']}:#{redis_port},"
end
redis_uri.chomp
# If override is not nil, use that
redis_uri = node['corndog']['redis']['uri'] || redis_uri
Chef::Log.info("Redis URI: #{redis_uri}")

node.normal['corndog']['dotenv'] = {
  'RAILS_ENV' => rails_env,
  'MONGODB_HOST_PORT_1' => mongodb_host_port_1,
  'MONGODB_HOST_PORT_2' => mongodb_host_port_2,
  'MONGODB_HOST_PORT_3' => mongodb_host_port_3,
  'MONGODB_DATABASE' => mongodb_database,
  'MONGODB_USERNAME' => mongodb_username,
  'MONGODB_PASSWORD' => mongodb_password,
  'MONGODB_OPTION_1' => mongodb_option_1,
  'MONGODB_OPTION_2' => mongodb_option_2,
  'MONGODB_OPTION_3' => mongodb_option_3,
  'REDIS_URI' => redis_uri,
  'CLOUDFRONT_HOST' => cloudfront_host,
  'CLOUDFRONT_ASSET_HOSTS' => cloudfront_asset_hosts
}

# Load defaults for all Corndog hosts and environments
include_recipe 'corndog-chef::default'
# Create the .env file from the attributes we've set here
include_recipe 'corndog-chef::dotenv'
