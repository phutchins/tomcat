user "jgerry" do
  comment "Jason Gerry"
  uid 1006
  gid 500
  home "/home/jgerry"
  shell "/bin/bash"
end

["/home/jgerry", "/home/jgerry/.ssh"].each do |dir|
  directory dir do
    mode 0700
    owner "jgerry"
    group "devops"
    action :create
  end
end

cookbook_file "/home/jgerry/.ssh/authorized_keys" do
  source "authorized_keys.jgerry"
  mode 0600
  owner "jgerry"
  group "devops"
  action :create
end
