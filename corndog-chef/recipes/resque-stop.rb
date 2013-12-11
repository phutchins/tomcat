execute "resque-stop" do
  user "root"
  command "bluepill resque stop"
  #only_if "ps -ef | egrep resque | egrep -v egrep | egrep -v bluepilld"
  action :run
end

