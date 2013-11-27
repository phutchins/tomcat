node.normal['scope'] = 'prod'

include_recipe 'corndog-chef::default'
include_recipe 'corndog-chef::profile-production'
