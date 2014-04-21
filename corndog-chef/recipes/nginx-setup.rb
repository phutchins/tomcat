include_recipe 'apt'
include_recipe 's3_file'

nginx_packages = {
  #"nginx-full" => "nginx-full_1.4.6-precise_amd64.deb",
  #"nginx-common" => "nginx-common_1.4.6-precise_all.deb",
  #"nginx" => "nginx_1.4.6-precise_all.deb"
  "init-system-helpers" => "1.7~precise1~ppa1",
  "nginx-full" => "1.4.6-1+precise0",
  "nginx-common" => "1.4.6-1+precise0",
  "nginx" => "1.4.6-1+precise0"
}

#nginx_packages.each do |pkg_name, file_name|
#  s3_file "/var/cache/apt/archives/#{file_name}" do
#    remote_path "/#{file_name}"
#    bucket "cdx-apt-repo"
#    aws_access_key_id "AKIAJ4TP2AWG2GYM6V6Q"
#    aws_secret_access_key "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"
#    not_if { File.exists?("/var/cache/apt/archives/#{file_name}") }
#  end
#end

apt_repository "DM_Apt_Repo" do
  uri "http://apt.dealermatch.biz/repo"
  distribution "precise"
  components ["main"]
#  keyserver "keyserver.ubuntu.com"
#  key "C300EE8C"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

nginx_packages.each do |pkg_name, pkg_version|
  package pkg_name do
    action :install
    version pkg_version
#    source "/var/cache/apt/archives/#{file_name}"
#    options "-o Dpkg::Options::='--force-depends','--force-confold'"
  end
end

#package "init-system-helpers" do
#  action :install
#  source "/var/cache/apt/archives/init-system-helpers_1.7~precise1~ppa1_all.deb"
#  version "1.7~precise1~ppa1"
#end
