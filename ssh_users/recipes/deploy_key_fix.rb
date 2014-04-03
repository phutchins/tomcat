directory "/home/deploy/.ssh" do
  owner "deploy"
  group "www-data"
  mode 0700
end

set_public_key(node[:ssh_users]["deploy"])
