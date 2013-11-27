# This file includes all attributes for production like environments
node.normal['corndog']['env'] = node['profile']

node.normal['corndog']['redis']['host'] = 'redis.host'
node.normal['corndog']['redis']['port'] = '6379'

node.normal['corndog']['env']['REDIS_URI'] = "#{node['corndog']['redis']['host']}:#{node['corndog']['redis']['port']}"
node['corndog']['mongodb'].each do |key, value|
  node.normal['corndog']['env']["mongodb_#{key}"] = value
end
