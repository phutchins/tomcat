user "phutchins" do
  comment "Philip Hutchins"
  uid 1005
  gid 500
  home "/home/phutchins"
  shell "/bin/bash"
end

["/home/phutchins", "/home/phutchins/.ssh"].each do |dir|
  directory dir do
    mode 0700
    owner "phutchins"
    group "devops"
    action :create
  end
end

cookbook_file "/home/phutchins/.ssh/authorized_keys" do
  source "authorized_keys.phutchins"
  mode 0600
  owner "phutchins"
  group "devops"
  action :create
end
