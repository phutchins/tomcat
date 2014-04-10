# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :resque do |resque_config|
    redis_config.vm.hostname = "resque-opsworks-v"
    redis_config.vm.box = "ubuntu_1204_chef_116"
    redis_config.vm.box_url = "http://cdx-devops.s3.amazonaws.com/ubuntu_1204_chef_116.box"
    redis_config.vm.network :private_network, ip: "33.33.33.9"
    redis_config.vm.network :forwarded_port, guest: 80, host: 80

    redis_config.vm.provision :chef_solo do |chef|
      #chef.data_bags_path = "./data_bags"
      chef.cookbooks_path = "."
      chef.add_recipe "base-opsworks"
      chef.add_recipe "redis::server"
      chef.json = {
        :authorization => {
          :sudo => {
            :users => ["vagrant", "phutchins", "jgerry"]
          }
        },
        :vagrant => true
      }
    end
  end

  config.vm.define :redis do |redis_config|
    redis_config.vm.hostname = "redis-opsworks-v"
    redis_config.vm.box = "ubuntu_1204_chef_116"
    redis_config.vm.box_url = "http://cdx-devops.s3.amazonaws.com/ubuntu_1204_chef_116.box"
    redis_config.vm.network :private_network, ip: "33.33.33.10"
    #redis_config.vm.network :forwarded_port, guest: 6379, host: 6379

    redis_config.vm.provision :chef_solo do |chef|
      #chef.data_bags_path = "./data_bags"
      chef.cookbooks_path = "."
      chef.add_recipe "base-opsworks"
      chef.add_recipe "redis::server"
      chef.json = {
        :authorization => {
          :sudo => {
            :users => ["vagrant", "phutchins", "jgerry"]
          }
        },
        :vagrant => true
      }
    end
  end

  config.vm.define :rails do |mysql_config|
    mysql_config.vm.hostname = "rails-opsworks-v"
    mysql_config.vm.box = "ubuntu_1204_chef_116"
    mysql_config.vm.box_url = "http://cdx-devops.s3.amazonaws.com/ubuntu_1204_chef_116.box"
    mysql_config.vm.network :private_network, ip: "33.33.33.11"
    #mysql_config.vm.network :forwarded_port, guest: 3306, host: 3306

    mysql_config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "."
      chef.add_recipe "corndog-chef::app-packages"
      chef.add_recipe "unicorn::rails"
      chef.add_recipe "base-opsworks"
      chef.add_recipe "rails::configure"
      chef.add_recipe "corndog-chef::steack-devopstest"
      chef.add_recipe "deploy::rails"
      chef.json = {
      }
    end
  end

  config.vm.define :mysql do |mysql_config|
    mysql_config.vm.hostname = "mysql-opsworks-v"
    mysql_config.vm.box = "ubuntu_1204_chef_116"
    mysql_config.vm.box_url = "http://cdx-devops.s3.amazonaws.com/ubuntu_1204_chef_116.box"
    mysql_config.vm.network :private_network, ip: "33.33.33.12"
    mysql_config.vm.network :forwarded_port, guest: 8080, host: 8080

    mysql_config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "."
      chef.add_recipe "corndog-chef::app-packages"
      chef.add_recipe "unicorn::rails"
      chef.add_recipe "base-opsworks"
      chef.add_recipe "rails::configure"
      chef.add_recipe "corndog-chef::steack-devopstest"
      chef.add_recipe "deploy::rails"
      chef.json = {
      }
    end
  end

  config.vm.define :mongodb do |mongodb_config|
    mysql_config.vm.hostname = "mongodb-opsworks-v"
    mysql_config.vm.box = "ubuntu_1204_chef_116"
    mysql_config.vm.box_url = "http://cdx-devops.s3.amazonaws.com/ubuntu_1204_chef_116.box"
    mysql_config.vm.network :private_network, ip: "33.33.33.12"
    mysql_config.vm.network :forwarded_port, guest: 8080, host: 8080

    mysql_config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "."
      chef.add_recipe "corndog-chef::app-packages"
      chef.add_recipe "unicorn::rails"
      chef.add_recipe "base-opsworks"
      chef.add_recipe "rails::configure"
      chef.add_recipe "corndog-chef::steack-devopstest"
      chef.add_recipe "deploy::rails"
      chef.json = {
      }
    end
  end
end
