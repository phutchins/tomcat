# This file includes all attributes for production like environments

node.normal['corndog']['redis']['host'] = 'redis.host'
node.normal['corndog']['redis']['port'] = '6379'

node.normal['corndog']['env']['REDIS_URI'] = "#{node['corndog']['redis']['host']}:#{node['corndog']['redis']['port']}"
