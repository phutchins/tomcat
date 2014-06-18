case node[:solr][:install_method]
when 'from_archive'
  include_recipe 'chef-solr::from_archive'
when 'from_package'
  include_recipe 'chef-solr::from_package'
else
  Chef::Log.info("You must set an install method via node[:solr][:install_method]")
end
