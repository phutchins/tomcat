include_recipe 'corndog-chef::devopstest'

template "/etc/bluepill_resque.pill" do
  owner 'root'
  group 'root'
  mode 0644
  source 'bluepill_resque.rb.erb'
  variables({
    :rails_env => rails_env
  })
  notifies :run, "execute[bluepill-resque-restart]", :immediately
end

execute "bluepill-resque-restart" do
  user "root"
  command "bluepill load /etc/bluepill_resque.pill"
  only_if { Dir.exists?("/srv/www/corndog/current") }
  action :nothing
end



