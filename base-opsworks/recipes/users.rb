unless node['vagrant']
  include_recipe "base-opsworks::user-ubuntu"
end
include_recipe "base-opsworks::user-phutchins"
include_recipe "base-opsworks::user-jgerry"

#node.default['authorization']['sudo']['prefix'] = '/etc'
#include_recipe "sudo"

#include_recipe "base-opsworks::sudoers"
