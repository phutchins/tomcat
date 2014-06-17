include_recipe 'base-opsworks'

node.default[:solr][:replication][:node_type] = "master"

include_recipe 'chef-solr'
include_recipe 'corndog-chef::solr-config'
