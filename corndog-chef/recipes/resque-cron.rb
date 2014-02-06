execute "run-rake-cron" do
  user "root"
  command "cd #{node['corndog']['app']['base_path']}/current && bundle exec whenever --write-crontab --set environment=#{node['corndog']['profile']}"
end
