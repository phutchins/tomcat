node.normal['scope'] = 'test'
#node.normal['profile'] = 'production'
node.normal['profile'] = 'test'

# modifying hostnames to ensure no colision with actual production
node.normal['corndog']['mongodb']['hosts'] = [
  "test1-cde-production.member.mongolayer.com:27017",
  "test2-cde-production.member.mongolayer.com:27017" ]
#  "cde-production.member2.mongolayer.com:27017",
#  "cde-production.member3.mongolayer.com:27017" ]
node.normal['corndog']['mongodb']['database'] = 'cde_production'

include_recipe 'corndog-chef::default'
include_recipe 'corndog-chef::profile-production'
include_recipe 'corndog-chef::dottenv'
