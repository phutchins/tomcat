config_path = node['corndog']['db']['config_path']
config_environment = node['scope']

def database_config
  @config ||= YAML.load_file("#{config_path}/database.yml")[config_environment]
end

def mysql_exec statement
  cmd = "ssh -o 'StrictHostKeyChecking no' -i /home/deploy/.ssh/internal #{node['corndog']['db']['host']} \"mysql -uroot -e '#{statement}'\""
  puts "Running: #{cmd}"
  run cmd
end

if !node['corndog']['db']['init_complete']
  begin
    Chef::Log.info("Remote Database is: #{database_config}")

    Chef::Log.info("granting access on kbb_etl to deploy")
    mysql_exec "create database if not exists kbb_etl"
    mysql_exec 'GRANT ALL ON kbb_etl.* TO \"deploy\"@\"%\";'

    Chef::Log.info("running migration script for etl load target")
    mysql_exec "create database if not exists etl_load_target"
    mysql_exec 'grant all on etl_load_target.* to \"deploy\"@\"%\";'
    node.normal['corndog']['db']['init_complete'] = true
  rescue Exception => e
    Chef::Log.fatal("Cannot initialize MySQL Database for Corndog!")
  end
end
