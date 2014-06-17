package "solr-common" do
  version node[:solr][:version]
  action :install
end

service "tomcat6" do
  supports :restart => true, :status => true
  action [:enable, :start]
end

template "/etc/solr/conf/solrconfig.xml" do
  source "solrconfig.xml.erb"
  variables({
    :max_time => node[:solr][:max_time]
#    :time_allowed => node[:solr][:time_allowed]
  })
  notifies :restart, "service[tomcat6]", :delayed
end
