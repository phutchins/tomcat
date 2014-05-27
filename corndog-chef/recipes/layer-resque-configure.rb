include_recipe 'corndog-chef::nginx-setup'
include_recipe 'base-opsworks::resque'
include_recipe 'corndog-chef::stack-init'
