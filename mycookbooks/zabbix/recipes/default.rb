#
# Cookbook Name:: zabbix-agent
# Recipe:: default
#
# constants

version     = node[:zabbix][:version]
zabbix_file = "zabbix-#{version}.tar.gz"
zabbix_dir  = "zabbix-#{version}"
download    = "https://s3.amazonaws.com/cdx-devops/zabbix-#{version}.tar.gz"

env = node[:environment][:framework_env]

# install only on select environments
node[:zabbix][:install_on_envs].include?(env)

# case app_master
case node[:instance_role]
when "app_master"
  hostname = "#{env}-app-master"
end

# case app
case node[:instance_role]
when "app"
  hostname = "#{env}-app"
end

# case db_master
case node[:instance_role]
when "db_master"
  hostname = "#{env}-db-master"
end

# case db_slave
case node[:instance_role]
when "db_slave"
  hostname = "#{env}-db-slave"
end

# case solo
case node[:instance_role]
when "solo"
  hostname = "#{env}-solo"
end

# case util
case node[:instance_role]
when "util"
  hostname = "#{env}-utility"
end


# main script

user "zabbix" do
  action :create
end

# don't reinstall if zabbix installs exists

if not FileTest.exists?("/data/#{zabbix_dir}")

  # get remote file
  remote_file "/data/#{zabbix_file}" do
    source download
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    backup 0
  end

  # untar, cd, config, make install
  execute "untar" do
    command "cd /data && tar zxf #{zabbix_file} && sync"
  end

  execute "config make install" do
    command "cd /data/#{zabbix_dir} && ./configure --enable-agent --prefix=#{node[:zabbix][:prefix]} && sudo make install"
  end

  # clean up and leave a file behind to show installed version
  execute "clean up installer" do
    command "sudo rm -rf /data/zabbix*"
  end

  cookbook_file "/data/#{zabbix_dir}" do
    source "empty_file"
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    backup 0
  end

end

directory "/var/log/zabbix" do
  action :create
  owner "zabbix"
  group "zabbix"
  mode 0755
end

directory "/usr/local/etc" do
  action :create
  owner "root"
  group "root"
  mode 0755
end

# init script
template "/etc/bluepill_zabbix_agent.pill" do
  source "bluepill_zabbix_agent.pill.erb"
  owner "root"
  group "root"
  mode 0755
end

# zabbix_agentd.conf file
template "#{node[:zabbix][:prefix]}/etc/zabbix_agentd.conf" do
  notifies :run, "execute[bluepill-zabbix-restart]"
  source "zabbix_agentd.conf.erb"
  owner "root"
  group "root"
  mode 0755
variables({
  :hostname         => hostname,
  :log_debug_level  => node[:zabbix][:log_debug_level],
  :server           => node[:zabbix][:server],
  :server_active    => node[:zabbix][:server_active],
  :start_agents     => node[:zabbix][:start_agents],
  :listen_port      => node[:zabbix][:listen_port],
  :server_port      => node[:zabbix][:server_port],
  :timeout          => node[:zabbix][:timeout]
})
end

execute "bluepill-zabbix-restart" do
  user "root"
  command "bluepill load /etc/bluepill_zabbix_agent.pill; sleep 5; bluepill zabbix-agentd restart"
  action :nothing
end


