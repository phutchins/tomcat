node.default['corndog']['app']['base_path'] = '/srv/www/corndog'
node.default['corndog']['app']['current_link'] = '/srv/www/corndog/current'
node.default['corndog']['app']['shared_path'] = '/srv/www/corndog/shared'

directory "/opt/corndog" do
  owner "deploy"
  group "www-data"
  action :create
end

# Remove any nil values from the hash so they are not added to the dotenv file
node.default['corndog']['dotenv'] = node['corndog']['dotenv'].to_hash.delete_if { |k,v| v.nil? }

template "/opt/corndog/dotenv" do
  source "dotenv.erb"
  owner "deploy"
  group "www-data"
  variables(
    :dot_env_attrs => node['corndog']['dotenv']
  )
end

corndog_path = node['corndog']['app']['current_link']
corndog_shared_path = node['corndog']['app']['shared_path']

Chef::Log.info("DotEnv Attrs: #{node['corndog']['dotenv'].inspect}")
