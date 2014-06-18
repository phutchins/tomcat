service "tomcat6" do
  supports :restart => true, :status => true
  action [:enable, :start]
end

template "/etc/solr/conf/solrconfig.xml" do
  source "solrconfig.xml.erb"
  variables({
    :max_time => node[:solr][:max_time]
  })
  notifies :restart, "service[tomcat6]", :delayed
end

