#
# Cookbook Name:: logstash
# Recipe:: default
#

make_directories = lambda do
  directory "/data/logstash" do
    owner node[:owner_name]
    group node[:owner_name]
    mode 0755
    action :create
  end

  directory "/var/log/logstash" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end
end

install_jar = lambda do |role, env|
  jarfile  = node[:logstash][:jarfile]
  download = "https://s3.amazonaws.com/cdx-devops/#{jarfile}"

  # install only on select roles
  return if not node[:logstash][:install_on_role].include?(role)

  # install only on select environments
  return if not node[:logstash][:install_on_envs].include?(env)

  remote_file "/data/logstash/#{jarfile}" do
    source download
    owner node[:owner_name]
    group node[:owner_name]
    mode 0755
    backup 0
  end

  # clean up old wrapper file
  file "/data/logstash/logstash_wrapper.sh" do
    action :delete
  end

  linkname = "/data/logstash/logstash.jar"
  linkdest = File.readlink(linkname) if File.symlink?(linkname)

  # get rid of the old logstash.jar binary if it exists
  if not File.symlink?(linkname)
    file linkname do
      action :delete
    end
  end

  #
  #if defined?(linkdest) and linkdest != jarfile
  #  link linkname do
  #    action :delete
  #  end
  #end

  link linkname do
    to "/data/logstash/#{jarfile}"
    notifies :run, "execute[logstash-restart]"#, :immediately
    #not_if "test -L /data/logstash/logstash.jar"
  end
end


configure_logstash = lambda do |hostname, env, role, templ|
  template "/data/logstash/filter.conf" do
    source "#{templ}.erb"
    owner node[:owner_name]
    group node[:owner_name]
    mode 0755
    variables({
      :hostname   => hostname,
      :role       => role,
      :env        => env
    })
    notifies :run, "execute[logstash-restart]"#, :immediately
  end
end

setup_bluepill = lambda do |hostname, env, role|
  template "/etc/bluepill_logstash.pill" do
    source "bluepill_logstash.pill.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
      :hostname   => hostname,
      :role       => role,
      :env        => env
    })
    notifies :run, "execute[logstash-reload]"#, :immediately
  end

  execute "logstash-reload" do
    user "root"
    command "bluepill load /etc/bluepill_logstash.pill"
    action :nothing
  end

  execute "logstash-restart" do
    user "root"
    command "bluepill logstash restart"
    action :nothing
  end

end

# Don't use a lambda here until we figure out scoping
apply_role = lambda do
  env  = node[:environment][:framework_env]
  role = node[:instance_role]

  case role
  when "app_master"
    hostname = "#{env}-app-master"
    templ    = "filter_appserver"
  when "app"
    hostname = "#{env}-app"
    templ    = "filter_appserver"
  when "util"
    hostname = "#{env}-utility"
    templ    = "filter_utility"
  when "db_master"
    hostname = "#{env}-db-master"
    templ = "filter_central"
  else
    hostname = "#{env}-#{role}"
    templ = "filter_central"
  end

  return hostname, env, role, templ
end

hostname, env, role, templ = apply_role.call
setup_bluepill.call(hostname, env, role)
make_directories.call
configure_logstash.call(hostname, env, role, templ)
install_jar.call(role, env)
