corndog_path = node['corndog']['app']['current_link']
gem_package 'dotenv-rails' do
  action :install
end

Chef::Log.info("DotEnv Attrs: #{node['corndog']['dotenv'].inspect}")

template "#{corndog_path}/.env" do
  source "dotenv.erb"
  owner "root"
  group "root"
  variables(
    :dot_env_attrs => node['corndog']['dotenv']
  )
  # Do we need to restart unicorn for environment variable changes?
  #  notifies :restart, resources(:service => "unicorn")
end
