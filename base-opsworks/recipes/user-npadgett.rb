user "npadgett" do
  comment "Nick Padgett"
  uid 1007
  gid 500
  home "/home/npadgett"
  shell "/bin/bash"
end

["/home/npadgett", "/home/npadgett/.ssh"].each do |dir|
  directory dir do
    mode 0700
    owner "npadgett"
    group "devops"
    action :create
  end
end

cookbook_file "/home/npadgett/.ssh/authorized_keys" do
  source "authorized_keys.npadgett"
  mode 0600
  owner "npadgett"
  group "devops"
  action :create
end

cookbook_file "/etc/sudoers.d/npadgett" do
  source "npadgett-sudo"
  mode 0440
  owner "root"
  group "root"
  action :create
end
