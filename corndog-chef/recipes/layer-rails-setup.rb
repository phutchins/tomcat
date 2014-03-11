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
%w{nginx nginx-full nginx-common}.each do |pkg|
  package pkg do
    action :install
    options "--force-yes"
    version "1.4.6-1+precise0"
  end
end
