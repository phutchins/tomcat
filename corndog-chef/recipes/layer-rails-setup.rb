include_recipe 'apt'

apt_repository "nginx-stable-precise" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  distribution "precise"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

apt_package "nginx-common" do
  action :install
  version "1.4.6-1+precise0"
end
