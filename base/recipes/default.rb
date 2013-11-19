include_recipe "base::chef-client"
include_recipe "base::hostname"
include_recipe "base::packages"
include_recipe "base::apt"
include_recipe "base::users"
include_recipe "base::auth"
if node['base']['enable-monitoring']
  include_recipe "base::monitoring"
end
