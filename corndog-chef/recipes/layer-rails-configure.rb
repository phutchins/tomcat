include_recipe "base-opsworks::rails-app"
include_recipe "corndog-chef::nginx-config"
include_recipe "corndog-chef::stack_init"
