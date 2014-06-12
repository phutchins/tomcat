stack = node[:wordpress][:stack]


dbuser = 'master'
dbpass = 'D0nkeyc0rn!'
dbhost = 'cdx-wordpress.c4fsy8hm6tiy.us-east-1.rds.amazonaws.com'

case
when stack == 'test'
  dbname = 'wptest'
  node.override[:apache][:prefork][:minspareservers] = 2
  node.override[:apache][:prefork][:maxspareservers] = 4
  node.override[:apache][:prefork][:startservers] = 4
when stack == 'production'
  dbname = 'wordpress'
  #node.override[:apache][:prefork][:minspareservers] = 2
  #node.override[:apache][:prefork][:maxspareservers] = 4
  #node.override[:apache][:prefork][:startservers] = 4
end

template "wp-config.php" do
  source 'wp-config.php.erb'
  user   'deploy'
  group  'www-data'
  mode   0644
  path   '/srv/www/wordpress/current/wp-config.php'
  notifies :restart, "service[apache2]", :immediately
  variables({
    :dbname => dbname,
    :dbuser => dbuser,
    :dbpass => dbpass,
    :dbhost => dbhost
  })
end

directory "upload" do
  user  'deploy'
  group 'www-data'
  mode  0775
  path  '/srv/www/wordpress/current/wp-content/uploads'
end

service "apache2" do
  init_command = '/etc/init.d/apache2'
  action = :nothing
end

