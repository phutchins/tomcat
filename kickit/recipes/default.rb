cookbook_file "/usr/local/bin/kickit.rb" do
  source "kickit.rb"
  action :create
  mode 0755
  owner "root"
  group "root"
end

case node["platform"]
when "ubuntu"
  cookbook_file "/etc/init/kickit.conf" do
    source "kickit.conf.upstart"
    action :create
    owner "root"
    group "root"
  end
when "mac_os_x"
  cookbook_file "/System/Library/LaunchDaemons/kickit.plist" do
    source "kickit.plist"
    action :create
    owner "root"
    group "root"
  end
end

service "kickit" do
  case node["platform"]
  when "ubuntu"
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true
  when "mac_os_x"
    provider Chef::Provider::Service::Macosx
    supports :status => true, :restart => true
  end
  action [ :enable, :start ]
end
