node.normal['corndog']['scope'] = 'devopstest'
node.normal['deploy']['Corndog_APP']['rails_env'] = 'devopstest'
include_recipe 'corndog-chef::profile-testing'

# Attributes from the OpsWorks Environment
redis_uri_port = "6379"
redis_uri = 'redis://'
node['opsworks']['layers']['redis'].each do |instance|
  redis_uri << instance['public_dns_name'] + "#{redis_port}"
end

Chef::Log.info("Redis URI: redis://#{redis_uri_hosts}")

node.normal['corndog']['dotenv'] = { 
  'RAILS_ENV' => 'devopstest',
  'MONGODB_HOST' => 'mongo-devopstest.dealermatch.biz:27017',
  'MONGODB_DATABASE' => 'cde_production',
  'MONGODB_OPTIONS' => '*mongo_session_options_with_ro_username_pass',
#  'REDIS_URI' => 'redis://redis-corndog-prod.zx3kal.0001.use1.cache.amazonaws.com:6379'
  'REDIS_URI' => redis_uri
# Will want to grab the MySQL master from OpsWorks attributes later
#  'MYSQL_MASTER_HOST' => node[:opsworks][:layers]['db-master'][:instances][:
}

include_recipe 'corndog-chef::default'
include_recipe 'corndog-chef::dotenv'
