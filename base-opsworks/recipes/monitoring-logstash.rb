include_recipe 'openssl'

node.default['logstash']['agent']['server_ipaddress'] = "logs.dealermatch.biz"

include_recipe "logstash::agent"
