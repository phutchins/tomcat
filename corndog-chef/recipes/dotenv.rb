corndog_path = node['corndog']['base_path']
gem_package 'dotenv-rails' do
  action :install
end

#f = File.open("#{corndog_path}/.env",'w')
#node['corndog']['env'].each do |key, value|
#  f.write("#{key}=#{value}")
#end
#f.close

template "#{corndog_path}/.env" do
  source "dotenv.erb"
  owner "root"
  group "root"
  variables(
    :dot_env_attrs => node['corndog']['env']
  )
# Do we need to restart unicorn for environment variable changes?
#  notifies :restart, resources(:service => "unicorn")
end
