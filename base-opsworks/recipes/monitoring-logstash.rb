include_recipe 'openssl'

node.default['logstash']['agent']['version'] = '1.3.3'
node.default['logstash']['agent']['server_ipaddress'] = "logs.dealermatch.biz"

package "openjdk-7-jdk" do
  action :install
end

include_recipe "logstash::agent"
