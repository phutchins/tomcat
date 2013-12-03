node.normal['scope'] = 'test'
node.normal['profile'] = 'test'

# modifying hostnames to ensure no colision with actual production
node.normal['corndog']['mongodb']['hosts'] = [
  "mongo-devopstest.dealermatch.biz:27017" ]
node.normal['corndog']['mongodb']['database'] = 'cde_production'

Chef::Log.info("DotEnv Attrs 2: #{node['corndog']['dotenv'].inspect}")

include_recipe 'corndog-chef::default'
include_recipe 'corndog-chef::profile-testing'
include_recipe 'corndog-chef::dotenv'
