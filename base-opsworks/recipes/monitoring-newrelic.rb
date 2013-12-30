gpg_key_id = node['newrelic']['repository_key']
gpg_key_url = "http://download.newrelic.com/#{gpg_key_id}.gpg"

execute "newrelic-add-gpg-key" do
  command "wget -O- #{gpg_key_url} | apt-key add -"
  notifies :run, "execute[newrelic-apt-get-update]", :immediately
  not_if "apt-key list | grep #{gpg_key_id}"
end

remote_file "/etc/apt/sources.list.d/newrelic.list" do
  source "http://download.newrelic.com/debian/newrelic.list"
  owner "root"
  group "root"
  mode 0644
  notifies :run, "execute[newrelic-apt-get-update]", :immediately
  action :create_if_missing
end

execute "newrelic-apt-get-update" do
  command "apt-get update"
  action :nothing
end

package "newrelic-sysmond" do
  action :install
end

service "newrelic-sysmond" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable, :start]
end
