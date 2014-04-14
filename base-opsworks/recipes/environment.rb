## env stuff goes here
## bashrc, htoprc, gemrc, etc

template "/home/deploy/.bashrc" do
  source "bashrc.erb"
  owner "deploy"
  group "www-data"
  mode 0644
  action :create
end
