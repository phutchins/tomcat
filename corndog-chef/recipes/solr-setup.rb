include_recipe 'apt'

#solr_packages = {
#  "solr-common" => "3.6.1+dfsg-0ubuntu2",
#  "solr-tomcat" => "3.6.1+dfsg-0ubuntu2"
#}

apt_repository "DM_Apt_Repo" do
  uri "http://apt.dealermatch.biz/repo"
  distribution "precise"
  components ["main"]
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

#solr_packages.each do |pkg_name, pkg_version|
#  package pkg_name do
#    action :install
#    version pkg_version
#    options "--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdel'"
#  end
#end
