node.normal['corndog']['scope'] = 'devopstest'
include_recipe 'corndog-chef::profile-testing'

node.normal['corndog']['dotenv'] = { 
  'RAILS_ENV' => 'devopstest',
  'MONGODB_HOST' => 'mongo-devopstest.dealermatch.biz:27017',
  'MONGODB_DATABASE' => 'cde_production',
  'MONGODB_OPTIONS' => '*mongo_session_options_with_ro_username_pass'
}

include_recipe 'corndog-chef::default'
include_recipe 'corndog-chef::dotenv'
