template "/etc/bluepill_resque.pill" do
  owner 'root'
  group 'root'
  mode 0644
  source 'resque.rb.erb'
  variables({
    :rails_env => node['deploy']['corndog']['rails_env']
  })
  notifies :run, "execute[resque-start]"
end

log "RAILS_ENV set to: #{node['deploy']['corndog']['rails_env']}"

execute "resque-stop" do
  user "root"
  command "bluepill resque stop"
  only_if "ps -ef | egrep resque | egrep -v egrep | egrep -v bluepilld"
  action :run
end

execute "resque-start" do
  user "root"
  command "bluepill load /etc/bluepill_resque.pill"
  not_if "ps -ef | egrep resque | egrep -v egrep | egrep -v bluepilld"
  action :run
end

