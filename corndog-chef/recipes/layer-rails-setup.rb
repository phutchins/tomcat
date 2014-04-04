include_recipe 's3_file'

nginx_packages = { "nginx-full" => "nginx-full_1.4.6-precise_amd64.deb", "nginx-common" => "nginx-common_1.4.6-precise_all.deb", "nginx" => "nginx_1.4.6-precise_all.deb" }

nginx_packages.each do |pkg_name, file_name|
  s3_file "/var/cache/apt/archives/#{file_name}" do
    remote_path "/#{file_name}"
    bucket "cdx-apt-repo"
    aws_access_key_id "AKIAJ4TP2AWG2GYM6V6Q"
    aws_secret_access_key "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"
    not_if { File.exists?("/var/cache/apt/archives/#{file_name}") }
  end
end

# Disabling this as the repo does not provide the version we use any more
#apt_repository "nginx-stable-precise" do
#  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
#  distribution "precise"
#  components ["main"]
#  keyserver "keyserver.ubuntu.com"
#  key "C300EE8C"
#  action :add
#  notifies :run, "execute[apt-get update]", :immediately
#end

nginx_packages.each do |pkg_name, file_name|
  package pkg_name do
    action :install
    source "/var/cache/apt/archives/#{file_name}"
    options "-o Dpkg::Options::='--force-confold'"
  end
end
