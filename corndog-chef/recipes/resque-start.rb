execute "resque-start" do
  user "root"
  command "bluepill load /etc/bluepill_resque.pill"
  only_if { Dir.exists?("/srv/www/corndog/current") }
  action :run
end


