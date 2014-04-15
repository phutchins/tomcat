include_recipe "base-opsworks::rails-app"
include_recipe "unicorn::config-nginx"
include_recipe "corndog-chef::stack_init"
