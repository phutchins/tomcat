directory "/opt/corndog" do
  owner "deploy"
  group "www-data"
  action :create
end

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
gem_package 'dotenv-rails' do
  action :install
end

#link "#{release_path}/.env" do
#  to "/opt/corndog/dotenv"
#end

#execute "symlinking dotenv config if necessary" do
#  command "rm #{release_path}/.env && ln -s /opt/corndog/dotenv #{release_path}/.env"
#  action :run
#end

Chef::Log.info("DotEnv Attrs: #{node['corndog']['dotenv'].inspect}")

#if !::File.directory?(corndog_shared_path)
#  Chef::Log.info("Rails shared path does not exist so not creating dotenv file!")
#end

#template "#{corndog_shared_path}/config/dotenv" do
#  source "dotenv.erb"
#  owner "root"
#  group "root"
#  variables(
#    :dot_env_attrs => node['corndog']['dotenv']
#  )
#  only_if { ::File.directory?(corndog_shared_path) }
#end


