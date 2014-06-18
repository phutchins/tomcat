include_recipe 'base-opsworks'
node.default[:solr][:replication][:node_type] = "slave"

if !node['opsworks']['layers']['solr']['instances'].nil?
  solr_opsworks_instance = node['opsworks']['layers']['solr']['instances'].first
  solr_master_dns = solr_opsworks_instance[1]['public_dns_name']
end
node.default[:solr][:replication][:master_url] = "http://#{solr_master_dns}:#{node[:solr][:port].to_s}/solr"

include_recipe 'corndog-chef::solr-config'
