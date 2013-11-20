directory "/var/chef/databags" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

remote_directory "/var/chef/databags" do
  source "databags"
  files_owner "root"
  files_group "root"
  owner "root"
  group "root"
  overwrite true
end
