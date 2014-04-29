cookbook_file "/etc/sudoers.d/deploy" do
  source "deploy-sudo"
  mode 0440
  owner "root"
  group "root"
  action :create
end

directory "/home/deploy/.ssh" do
  mode 0700
  owner "deploy"
  action :create
end

cookbook_file "/home/deploy/.ssh/authorized_keys" do
  source "authorized_keys.deploy"
  mode 0400
  owner "deploy"
  action :create
end
