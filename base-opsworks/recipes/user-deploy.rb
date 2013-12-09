cookbook_file "/etc/sudoers.d/deploy" do
  source "deploy-sudo"
  mode 0440
  owner "root"
  group "root"
  action :create
end
