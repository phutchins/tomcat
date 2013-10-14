#
# Cookbook Name:: resque
# Recipe:: default
#

if ['solo'].include?(node['instance_role']) or (node['instance_role'] == 'util' and node['name'] == 'resque')
  node.applications.each do |app_name, data|
    rails_env = node.environment['framework_env']
    shared_location = "/data/#{app_name}/shared"
    workers_config = YAML.load_file("#{File.dirname(__FILE__)}/../workers.yml")[rails_env]
    num_workers = workers_config.values.inject(0) { |sum, n| sum + n }

    cookbook_file "/engineyard/bin/resque-web" do
      owner 'root'
      group 'root'
      mode 0755
      if Chef::VERSION == '0.6.0.2'
        source "resque-web"
      end
    end

    directory "/data/run" do
      owner 'deploy'
      group 'deploy'
      mode 0755
      #recursive true
      action :create
    end

    template "/etc/bluepill_resque.pill" do
      owner 'root'
      group 'root'
      mode 0644
      source 'bluepill_resque.rb.erb'
      variables({
        :workers_config => workers_config,
        :app_name => app_name,
        :rails_env => rails_env
      })
      notifies :run, "execute[bluepill-resque-restart]", :immediately
    end

    workers_config.each do |queue, number_workers_for_queue|
      count = 0
      number_workers_for_queue.times do
        template "/data/#{app_name}/shared/config/resque_#{queue}_#{count}.conf" do
          owner node.owner_name
          group node.owner_name
          mode 0644
          source 'resque_wildcard.conf.erb'
          variables({
            :queues => queue
          })
          count += 1
        end
      end
    end

    execute "bluepill-resque-restart" do
      user "root"
      command "bluepill load /etc/bluepill_resque.pill"
      only_if { Dir.exists?("/data/corndog/current") }
      action :nothing
    end

    execute "fix permissions in log dir" do
      user "root"
      command "chmod 0666 /data/corndog/shared/log/*; chown deploy: /data/corndog/shared/log/*"
      only_if { Dir.entries("/data/corndog/shared/log").size > 2 }
      action :run
    end

  end
end
