# nginx config
cookbook_file "log_format" do
  path '/etc/nginx/conf.d/log_format.conf'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[nginx]"
end

#template "/etc/nginx/sites-available/corndog" do
#  owner 'root'
#  group 'root'
#  mode 0644
#  source 'nginx.conf.erb'
#  variables({
#    :hostname => node[:opsworks][:instance][:hostname]
#  })
#  notifies :restart, "service[nginx]"
#end

service "nginx" do
  action [ :enable, :start ]
end
