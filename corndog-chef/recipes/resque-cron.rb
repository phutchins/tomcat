execute "run-rake-cron" do
  user "root"
  command "cd #{node['corndog']['app']['base_path']} && bundle exec whenever --write-crontab --set environment=#{node['corndog']['profile']}"
end
