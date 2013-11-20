group "devops" do
  gid 500
  action :create
end

user "phutchins" do
  comment "Philip Hutchins"
  uid 1005
  gid 500
  home "/home/phutchins"
  shell "/bin/bash"
end

["/home/phutchins", "/home/phutchins/.ssh"].each do |dir|
directory dir do
  mode 700
  owner "phutchins"
  group "phutchins"
  action :create
end

cookbook_file "/home/phutchins/.ssh/authorized_keys" do
  source "authorized_keys.phutchins"
  mode 600
  owner "phutchins"
  group "phutchins"
  action :create
end

include_recipe "sudo"
