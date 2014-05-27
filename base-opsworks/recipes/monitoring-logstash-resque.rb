# Pull this from somewhere in opsworks attrs
node.default['corndog']['profile'] = 'production'

node.override['logstash']['user'] = 'deploy'
node.override['logstash']['supervisor_gid'] = 'www-data'

stack_name = node['corndog']['stack']
profile_name = node['corndog']['profile']
host_role = node['corndog']['host_role']

include_recipe 'logstash::agent'

node.default['corndog']['host_role'] = 'resque'
node.default['corndog']['profile'] = 'production'

stack_name = node['corndog']['stack']
profile_name = node['corndog']['profile']
host_role = node['corndog']['host_role']

# let's include a normal, sane, erb template for config
template 'logstash.conf' do
  source 'logstash-resque.conf.erb'
  path '/opt/logstash/agent/etc/conf.d/logstash.conf'
  owner node['logstash']['user']
  group node['logstash']['group']
  variables(:stack_name => stack_name, :host_role => host_role)
  mode '0644'
  notifies :restart, "service[logstash_agent]"
end
