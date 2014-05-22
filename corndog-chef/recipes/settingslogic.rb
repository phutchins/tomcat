node.normal['corndog']['app']['base_path'] = '/srv/www/corndog'
node.normal['corndog']['app']['current_link'] = '/srv/www/corndog/current'
node.normal['corndog']['app']['shared_path'] = '/srv/www/corndog/shared'

directory "/opt/corndog" do
  owner "deploy"
  group "www-data"
  action :create
end

# Remove any nil values from the hash so they are not added to the dotenv file
#node.default['corndog'] = node['corndog'].to_hash.delete_if { |k,v| v.nil? }

template "/opt/corndog/application.yml" do
  source "settingslogic.erb"
  owner "deploy"
  group "www-data"
  variables(
    :corndog_hash => node['corndog'].to_hash,
    :stack => node['corndog']['stack']
  )
  notifies :restart, "service[unicorn_corndog]", :delayed
end

service "unicorn_corndog" do
  start_command "#{node['corndog']['app']['base_path']}/shared/scripts/unicorn start"
  stop_command "#{node['corndog']['app']['base_path']}/shared/scripts/unicorn stop"
  restart_command "#{node['corndog']['app']['base_path']}/shared/scripts/unicorn restart"
  status_command "#{node['corndog']['app']['base_path']}/shared/scripts/unicorn status"
  action :nothing
end

Chef::Log.info("SettingsLogic Values: #{node['corndog'].inspect}")
