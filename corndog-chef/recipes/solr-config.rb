cookbook_file "schema.xml" do
  path '/etc/solr/conf/schema.xml'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[tomcat6]"
end
