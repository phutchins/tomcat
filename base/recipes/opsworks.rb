# Point chef-solo at the folder containing our data bags for use with the users recipe
node.normal['data_bag_path'] = '/var/chef/data_bags'

include_recipe "base::solo-files"
include_recipe "base::solo-search"
include_recipe "base::packages"
include_recipe "base::apt"
include_recipe "base::users"
#include_recipe "base::auth"
if node['base']['enable-monitoring']
  include_recipe "base::monitoring"
end
