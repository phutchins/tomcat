package "solr-common" do
  version "1.4.1+dfsg1-2ubuntu2"
  action :install
end

#service "solr" do
#  supports :restart => true, :status => true
#  action [:enable, :start]
#end

template "/etc/solr/conf/solrconfig.xml" do
  source "solrconfig.xml.erb"
  variables({
    :max_time => node[:solr][:max_time]
#    :time_allowed => node[:solr][:time_allowed]
  })
  notifies :restart, "service[solr]", :delayed
end
