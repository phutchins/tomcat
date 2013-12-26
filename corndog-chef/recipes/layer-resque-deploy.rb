#log "RAILS_ENV set to: #{node['deploy']['corndog']['rails_env']}"
#log "deploy_to set to: #{node['deploy']['corndog']['deploy_to']}"

template "/etc/bluepill_resque.pill" do
  owner 'root'
  group 'root'
  mode 0644
  source 'resque.rb.erb'
  variables({
    #:rails_env => node['deploy']['corndog']['rails_env'],
    :rails_env => 'production',
    #:deploy_to => node['deploy']['corndog']['deploy_to']
    :deploy_to => '/srv/www/corndog'
  })
  notifies :run, "execute[resque-start]"
end


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

