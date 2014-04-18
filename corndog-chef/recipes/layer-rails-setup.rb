include_recipe 'corndog-chef::app-packages'
include_recipe 'corndog-chef::nginx-setup'
include_recipe 'corndog-chef::nginx-config'
include_recipe 'corndog-chef::stack-init'
