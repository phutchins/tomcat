corndog_path = node['corndog']['app']['current_link']
corndog_shared_path = node['corndog']['app']['shared_path']
gem_package 'dotenv-rails' do
  action :install
end

Chef::Log.info("DotEnv Attrs: #{node['corndog']['dotenv'].inspect}")

if !Dir.exists?(corndog_shared_path)
  Chef::Log.info("Rails shared path does not exist so not creating dotenv file!")
end

template "#{corndog_shared_path}/config/dotenv" do
  source "dotenv.erb"
  owner "root"
  group "root"
  variables(
    :dot_env_attrs => node['corndog']['dotenv']
  )
  only_if { ::Dir.exist?(corndog_shared_path) }
end
