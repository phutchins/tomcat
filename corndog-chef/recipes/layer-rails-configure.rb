include_recipe "base-opsworks::rails-app"
include_recipe "unicorn::config-nginx"
include_recipe "opsworks-corndog::stack_init"
