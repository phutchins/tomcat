node.normal['scope'] = 'prod'
node.normal['profile'] = 'production'

# modifying hostnames to ensure no colision with actual production
node.normal['corndog']['mongodb']['hosts'] = [
  "test1-cde-production.member.mongolayer.com:27017",
  "test2-cde-production.member.mongolayer.com:27017" ]
#  "cde-production.member2.mongolayer.com:27017",
#  "cde-production.member3.mongolayer.com:27017" ]
node.normal['corndog']['mongodb']['database'] = 'cde_production'

Chef::Log.info("DotEnv Attrs 2: #{node['corndog']['dotenv'].inspect}")

include_recipe 'corndog-chef::default'
include_recipe 'corndog-chef::profile-production'
include_recipe 'corndog-chef::dotenv'
