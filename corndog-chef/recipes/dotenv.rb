corndog_path = node['corndog']['base_path']
gem_package 'dotenv-rails' do
  action :install
end

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
