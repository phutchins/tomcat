node.default['logstash']['agent']['server_ipaddress'] = "logs.dealermatch.biz"

stack_name = node['corndog']['stack']


include_recipe "logstash::agent"
