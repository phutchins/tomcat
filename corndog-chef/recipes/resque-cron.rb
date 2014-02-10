execute "run-rake-cron" do
  user "deploy"
  command "cd #{node['corndog']['app']['base_path']}/current && bundle exec whenever --write-crontab --set environment=#{node['corndog']['profile']}"
end
