include_recipe 'chef-solr::configure'

cookbook_file "schema.xml" do
  path File.join(node[:solr][:base_dir], '/conf/schema.xml')
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[tomcat6]"
end
