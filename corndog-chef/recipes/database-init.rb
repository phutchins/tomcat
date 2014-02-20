config_path = node['corndog']['db']['config_path']
config_environment = node['scope']

#def database_config
#  @config ||= YAML.load_file("#{config_path}/database.yml")[config_environment]
#end
execute "create kbb_etl database" do
  user = 'deploy'
  command "echo 'create database if not exists kbb_etl' | mysql"
  not_if = "echo 'show databases' | mysql | egrep kbb_etl"
  Chef::Log.info("creating kbb_etl database")
end

execute "grants for kbb_etl database" do
  user = 'deploy'
  command "echo 'GRANT ALL ON kbb_etl.* TO \"deploy\"@\"%\"' | mysql"
  Chef::Log.info("granting roles on kbb_etl to deploy")
end

execute "create etl_load_target database" do
  user = "deploy"
  command "echo 'create database if not exists etl_load_target' | mysql"
  not_if = "echo 'show databases' | mysql | egrep etl_load_target"
  Chef::Log.info("creating etl_load_target database")
end

execute "grants for etl_load_target database" do
  user = "deploy"
  command "echo 'grant all on etl_load_target.* to \"deploy\"@\"%\"' | mysql"
  Chef::Log.info("granting roles on etl_load_target to deploy")
end


