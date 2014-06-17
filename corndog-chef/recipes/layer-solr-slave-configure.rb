include_recipe 'base-opsworks'

node.default[:solr][:replication][:node_type] = "slave"
(node[:corndog][:stack] = "production") ? domain = "dealermatch.com" : domain = "dealermatch.biz"
node.default[:solr][:replication][:master_url] = "solr-#{node[:corndog][:stack]}.#{domain}"

include_recipe 'chef-solr'
include_recipe 'corndog-chef::solr-config'
