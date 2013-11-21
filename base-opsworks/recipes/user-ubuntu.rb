group "ubuntu" do
  gid 1000
  action :create
end

user "ubuntu" do
  comment "Philip Hutchins"
  uid 1000
  gid 1000
  home "/home/ubuntu"
  shell "/bin/bash"
end

["/home/ubuntu", "/home/ubuntu/.ssh"].each do |dir|
  directory dir do
    mode 0700
    owner "ubuntu"
    group "devops"
    action :create
  end
end

cookbook_file "/home/ubuntu/.ssh/authorized_keys" do
  source "authorized_keys.ubuntu"
  mode 0600
  owner "ubuntu"
  group "devops"
  action :create
end

include_recipe "sudo"
