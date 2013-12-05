node.normal['corndog']['dotenv'] = { 
  'RAILS_ENV' => 'test',
  'MONGODB_HOST' => 'mongo-devopstest.dealermatch.biz:27017',
  'MONGODB_DATABASE' => 'cde_production',
  'MONGODB_OPTIONS' => '*mongo_session_options_with_ro_username_pass',
  'MYSQL_HOST' => '10.206.73.203'
}

node.normal['corndog']['scope'] = 'test'
node.normal['corndog']['profile'] = 'test'

# modifying hostnames to ensure no colision with actual production
node.normal['corndog']['mongodb']['hosts'] = [
  "mongo-devopstest.dealermatch.biz:27017" ]
node.normal['corndog']['mongodb']['database'] = 'cde_production'

Chef::Log.info("DotEnv Attrs 2: #{node['corndog']['dotenv'].inspect}")

include_recipe 'corndog-chef::default'
include_recipe 'corndog-chef::profile-testing'
include_recipe 'corndog-chef::dotenv'
