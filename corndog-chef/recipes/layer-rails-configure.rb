include_recipe 'corndog-chef::nginx-setup'
include_recipe 'base-opsworks::rails-app'
include_recipe 'corndog-chef::stack-init'
