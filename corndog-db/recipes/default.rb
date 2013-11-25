cookbook_file "#{node['corndog']['db']['config_path']}/database.yml" do
  source "database.yml"
  owner "root"
  group "root"
  action :create
end

include_recipe 'corndog-db::database-init'
