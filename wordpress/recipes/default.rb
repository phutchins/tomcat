stack = node[:wordpress][:stack]

# override attributes
node.override[:apache][:prefork][:minspareservers] = 2
node.override[:apache][:prefork][:maxspareservers] = 4
node.override[:apache][:prefork][:startservers] = 4
##

dbuser = 'master'
dbpass = 'D0nkeyc0rn!'
dbhost = 'cdx-wordpress.c4fsy8hm6tiy.us-east-1.rds.amazonaws.com'

case
when stack == 'test'
  dbname = 'wptest'
when stack == 'production'
  dbname = 'wordpress'
end

template "wp-config.php" do
  source = 'wp-config.php.erb'
  user   = 'deploy'
  group  = 'www-data'
  mode   = 0644
  path   = '/srv/www/wordpress/shared/wp-config.php'
  notifies :restart, "service[apache2]", :immediately
  variables({
    :dbname => dbname,
    :dbuser => dbuser,
    :dbpass => dbpass,
    :dbhost => dbhost
  })
end

#cookbook_file "wp-config.php" do
  #user  = 'www-data'
  #group = 'www-data'
  #mode  = 0644
  #path  = '/srv/www/wordpress/current/wp-config.php'
  #source = "wp-config.php.#{stack}"
  #notifies :restart, "service[apache2]", :immediately
#end

service "apache2" do
  init_command = '/etc/init.d/apache2'
  action = :nothing
end

