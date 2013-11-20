remote_directory "/var/chef/data_bags" do
  source "/tmp/vagrant-chef-1/chef-solo-1/cookbooks/base/files/default/data_bags"
  files_owner "root"
  files_group "root"
  owner "root"
  group "root"
  overwrite true
end
