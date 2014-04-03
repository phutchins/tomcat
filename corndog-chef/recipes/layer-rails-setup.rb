include_recipe 'apt'

%w{nginx-full_1.4.6-1+precise0_amd64.deb nginx-common_1.4.6-1+precise0_all.deb nginx_1.4.6-1+precise0_all.deb}.each do |pkg|
  s3_file "/var/cache/apt/archives/#{pkg}" do
    remote_path "/#{pkg}"
    bucket "cdx-apt-packages"
    aws_access_key_id "AKIAJ4TP2AWG2GYM6V6Q"
    aws_secret_access_key "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"
    not_if { File.exists?("/var/cache/apt/archives/#{pkg}") }
  end
end

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
    options "-o Dpkg::Options::='--force-confold'"
    version "1.4.6-1+precise0"
  end
end
