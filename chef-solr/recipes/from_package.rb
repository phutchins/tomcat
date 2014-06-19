package "solr-common" do
  version node[:solr][:version]
  action :install
end
