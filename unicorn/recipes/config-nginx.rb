if ! node[:opsworks][:layers]['resque']
  # nginx config
  cookbook_file "log_format" do
    path '/etc/nginx/conf.d/log_format.conf'
    owner 'root'
    group 'root'
    only_if "test -d /etc/nginx/conf.d"
    mode 0644
  end

  template "/etc/nginx/sites-available/corndog" do
    owner 'root'
    group 'root'
    mode 0644
    source 'nginx.conf.erb'
    variables({
      :hostname => node[:opsworks][:instance][:hostname]
    })
    only_if "test -d /etc/nginx/sites-available"
    notifies :restart, "service[nginx]"
  end

  service "nginx" do
    action [ :enable, :start ]
  end
end

