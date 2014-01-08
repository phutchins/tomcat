include_recipe 'openssl'

node.default['logstash']['user'] = 'root'
node.default['logstash']['group'] = 'root'

node.default['logstash']['agent']['server_ipaddress'] = "logs.dealermatch.biz"

script "make logs readable" do
  interpreter "bash"
  user "root"
  cwd "/var/log"
  code "chmod -R 664 /var/log/nginx"
end

include_recipe "logstash::agent"
