archive_file_path = File.join(Chef::Config[:file_cache_path], node[:solr][:archive_name])

package "tomcat6" do
  version node[:tomcat][:version]
  action :install
end

directory node[:solr][:base_dir] do
  user "tomcat6"
  action :create
end

directory "/etc/solr/conf" do
  recursive true
  action :create
end

directory "/var/lib/solr/data" do
  recursive true
  action :create
end

remote_file archive_file_path do
  source File.join(node[:solr][:download_url], node[:solr][:archive_name])
  notifies :run, "execute[extract_package]", :immediately
end

execute "extract_package" do
  command "tar -zxf #{File.join(Chef::Config[:file_cache_path], node[:solr][:archive_name])} -C #{Chef::Config[:file_cache_path]}"
  action :nothing
  notifies :run, "execute[copy_solr]", :immediately
  if node[:solr][:multicore][:enabled] then
    notifies :run, "execute[copy_multicore]", :immediately
  else
    notifies :run, "execute[copy_singlecore]", :immediately
  end
end

execute "copy_solr" do
  command "cp -r #{File.join(Chef::Config[:file_cache_path], node[:solr][:extract_dir_name], 'dist', node[:solr][:war_name])} #{node[:solr][:base_dir]}"
  action :nothing
end

execute "copy_multicore" do
  command "cp -r #{File.join(Chef::Config[:file_cache_path], node[:solr][:extract_dir_name], 'example/multicore/*')} #{node[:solr][:base_dir]}"
  action :nothing
end

execute "copy_singlecore" do
  command "cp -r #{File.join(Chef::Config[:file_cache_path], node[:solr][:extract_dir_name], 'example/solr/*')} #{node[:solr][:base_dir]}"
  action :nothing
end

execute "set_permissions" do
  command "chown -R tomcat6 #{node[:solr][:base_dir]}"
end

template "/etc/tomcat6/Catalina/localhost/solr.xml" do
  group "tomcat6"
  variables ({
    :solr_war_name => node[:solr][:war_name],
    :solr_base_dir => node[:solr][:base_dir]
  })
  action :create
end

service "tomcat6" do
  supports :restart => true, :status => true
  action [:enable, :start]
end
