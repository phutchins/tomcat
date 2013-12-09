execute "resque-stop" do
  user "root"
  command "bluepill resque stop"
  action :run
end

