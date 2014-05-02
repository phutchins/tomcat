# kill bluepill with fire!!
# NOTE remove this bluepill stuff later
execute "bluepill kill" do
  user "root"
  command "kill -9  `ps aux | grep [r]esque | grep -v grep | cut -c 10-16`"
  only_if "ps -ef | egrep bluepilld | egrep -v egrep"
end

file "/etc/bluepill_resque.pill" do
  action :delete
end

file "/etc/init.d/god" do
  action :delete
end
########

directory "/srv/www/corndog/shared/pids" do
  action :create
  owner 'deploy'
  group 'www-data'
  mode 0644
end

template '/etc/god.rb' do
  source 'god.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables({
    :rails_env => 'production',
    :deploy_to => '/srv/www/corndog'
  })
  #notifies :run, "execute[resque-restart]", :delayed
end

execute "resque-stop" do
  user "root"
  command "god terminate; sleep 5"
  action :run
  only_if "ps -ef | egrep [g]od"
  #ignore_failure true
end

execute "resque-start" do
  user "root"
  command "god -c /etc/god.rb -l /var/log/god.log"
  only_if "test -h /srv/www/corndog/current"
  action :run
end

