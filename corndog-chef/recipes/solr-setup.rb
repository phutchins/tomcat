include_recipe "corndog-chef::solr-#{node['corndog']['stack']}"
include_recipe 'chef-solr::install'
