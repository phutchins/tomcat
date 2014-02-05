run "cd #{node['corndog']['app']['base_path']} && bundle exec whenever --write-crontab --set environment=#{node['corndog']['profile']}"
