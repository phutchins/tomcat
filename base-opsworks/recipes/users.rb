unless node['vagrant']
  include_recipe "base-opsworks::user-ubuntu"
end
include_recipe "base-opsworks::user-phutchins"
include_recipe "base-opsworks::user-jgerry"

include_recipe "sudo"
