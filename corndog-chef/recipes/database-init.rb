config_path = node['corndog']['db']['config_path']
config_environment = node['scope']

dbcall = "mysql -u root -p#{node[:mysql][:server_root_password]}"

execute "create kbb_etl database" do
  user = 'deploy'
  command "echo 'create database if not exists kbb_etl' | #{dbcall}"
  not_if = "echo 'show databases' | #{dbcall} | egrep kbb_etl"
  Chef::Log.info("creating kbb_etl database")
end

execute "grants for kbb_etl database" do
  user = 'deploy'
  command "echo 'GRANT ALL ON kbb_etl.* TO \"deploy\"@\"%\"' | #{dbcall}"
  Chef::Log.info("granting roles on kbb_etl to deploy")
end

execute "create etl_load_target database" do
  user = "deploy"
  command "echo 'create database if not exists etl_load_target' | #{dbcall}"
  not_if = "echo 'show databases' | #{dbcall} | egrep etl_load_target"
  Chef::Log.info("creating etl_load_target database")
end

execute "grants for etl_load_target database" do
  user = "deploy"
  command "echo 'grant all on etl_load_target.* to \"deploy\"@\"%\"' | #{dbcall}"
  Chef::Log.info("granting roles on etl_load_target to deploy")
end


