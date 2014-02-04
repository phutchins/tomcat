# This file includes all logic for testing like environments

profile = 'testing'
rails_env = 'production'
node.normal['corndog']['profile'] = profile

# Retrieve attributes from node object
# Required attributes (add some logic here to fail if not assigned)
mongodb_host_port_1 = node['corndog']['mongodb']['host_port_1']
mongodb_database = node['corndog']['mongodb']['database']
mongodb_username = node['corndog']['mongodb']['username']
mongodb_password = node['corndog']['mongodb']['password']
redis_port = node['corndog']['redis']['port']
solr_host = node['corndog']['solr']['host']
solr_port = node['corndog']['solr']['port']
solr_path = node['corndog']['solr']['path']
solr_master_host = node['corndog']['solr']['master_host']
solr_master_port = node['corndog']['solr']['master_port']
solr_master_path = node['corndog']['solr']['master_path']
cloudfront_asset_hosts = node['corndog']['cloudfront']['asset_hosts']

# Additional attributes
mongodb_host_port_2 ||= node['corndog']['mongodb']['host_port_2']
mongodb_host_port_3 ||= node['corndog']['mongodb']['host_port_3']
mongodb_identity_map_enabled ||= node['corndog']['mongodb']['identity_map_enabled']
mongodb_consistency ||= node['corndog']['mongodb']['consistency']
mongodb_session_options ||= node['corndog']['mongodb']['session_options']

# Attributes from the OpsWorks Environment
if !node['opsworks']['layers']['redis']['instances'].nil?
  redis_uri = 'redis://'
  node['opsworks']['layers']['redis']['instances'].each do |instance|
    Chef::Log.info("Adding instance '#{instance[0]}' to Redis URI with hostname '#{instance[1]['public_dns_name']}'")
    redis_uri << "#{instance[1]['public_dns_name']}:#{redis_port},"
  end
end
redis_uri.chop!
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
  'MONGODB_IDENTITY_MAP_ENABLED' => mongodb_identity_map_enabled,
  'MONGODB_CONSISTENCY' => mongodb_consistency,
  'REDIS_URI' => redis_uri,
  'SOLR_HOST' => solr_host,
  'SOLR_PORT' => solr_port,
  'SOLR_PATH' => solr_path,
  'SOLR_MASTER_HOST' => solr_master_host,
  'SOLR_MASTER_PORT' => solr_master_port,
  'SOLR_MASTER_PATH' => solr_master_path,
  'CLOUDFRONT_ASSET_HOSTS' => cloudfront_asset_hosts
}

# Load defaults for all Corndog hosts and environments
run_context.include_recipe 'corndog-chef::default'
# Create the .env file from the attributes we've set here
run_context.include_recipe 'corndog-chef::dotenv'
