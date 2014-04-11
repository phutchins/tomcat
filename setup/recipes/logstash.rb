#include_recipe 'openssl'

node.default['logstash']['agent']['version'] = '1.3.3'
#node.default['logstash']['agent']['server_ipaddress'] = "logs.dealermatch.biz"
node.override['logstash']['user'] = 'deploy'
node.override['logstash']['group'] = 'www-data'

include_recipe "logstash::agent"

