include_recipe 'apt'

apt_repository "nginx" do
  uri "http://ppa.launchpad.net/nginx"
  distribution "precise"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

apt_package "nginx" do
  action :install
  version "1.4.5"
end
