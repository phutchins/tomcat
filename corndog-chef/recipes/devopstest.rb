node.normal['corndog']['scope'] = 'devopstest'
node.normal['deploy']['Corndog_APP']['rails_env'] = 'devopstest'
include_recipe 'corndog-chef::profile-testing'

# Attributes from the OpsWorks Environment
redis_port = "6379"
redis_uri = 'redis://'
node['opsworks']['layers']['redis']['instances'].each do |instance|
  Chef::Log.info("instance['public_dns_name']: #{instance.inspect}")
  #Chef::Log.info("redis_port: #{redis_port}")
# Broken due to can't convert String into Integer...
#  redis_uri << "#{instance['public_dns_name']}#{redis_port}"
end

redis_uri = 'redis://ec2-174-129-131-103.compute-1.amazonaws.com'

Chef::Log.info("Redis URI: #{redis_uri}")

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
