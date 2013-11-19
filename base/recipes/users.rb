group "devops" do
  gid 500
  action :create
end

include_recipe "users"
include_recipe "sudo"
