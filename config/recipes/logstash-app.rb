include_recipe 'base-opsworks'
include_recipe 'logstash::agent'

node.default['corndog']['host_role'] = 'rails_app'
node.default['corndog']['profile'] = 'production'

stack_name = node['corndog']['stack']
profile_name = node['corndog']['profile']
host_role = node['corndog']['host_role']

directory "/var/log/nginx" do
  owner 'www-data'
  group 'root'
   mode 0755
end

script "make logs readable" do
  interpreter "bash"
  user "root"
  cwd "/var/log"
  code "chmod 664 /var/log/nginx/*"
end

# let's include a normal, sane, erb template for config
template 'logstash.conf' do
  source 'logstash-app.conf.erb'
  path '/opt/logstash/agent/etc/conf.d/logstash.conf'
  owner node['logstash']['user']
  group node['logstash']['group']
  variables(:stack_name => stack_name, :host_role => host_role)
  mode '0644'
  notifies :restart, service_resource
end


