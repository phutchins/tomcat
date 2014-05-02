execute "resque-shutdown" do
  user "root"
  command "god terminate; sleep 5"
  action :run
  only_if "ps -ef | egrep [g]od"
  ignore_failure true
end

