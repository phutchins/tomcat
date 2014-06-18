package "solr-common" do
  version node[:solr][:version]
  action :install
end

service "tomcat6" do
  supports :restart => true, :status => true
  action [:enable, :start]
end
