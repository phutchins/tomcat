## env stuff goes here
## bashrc, htoprc, gemrc, etc

cookbook_file "/home/deploy/.bashrc" do
  source "bashrc.deploy"
  mode "0644"
  owner "deploy"
  group "www-data"
  action :create
  only_if { File.exist?("/home/deploy") }
end
