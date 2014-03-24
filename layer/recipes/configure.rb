include_recipe 'base-opsworks::monitoring-app'
include_recipe 'base-opsworks'
include_recipe 'unicorn::config-nginx'
include_recipe 'corndog-chef::layer-rails-configure'


