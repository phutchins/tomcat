execute "resque-restart" do
  user "root"
  command "bluepill resque reload"
  only_if { Dir.exists?("/srv/www/corndog/current") }
  action :run
end


