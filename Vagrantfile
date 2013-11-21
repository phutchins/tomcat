# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :redis do |redis_config|
    redis_config.vm.hostname = "redis-opsworks-v"
    redis_config.vm.box = "ubuntu_1204_chef_116"
    redis_config.vm.box_url = "http://cdx-devops.s3.amazonaws.com/ubuntu_1204_chef_116.box"
    redis_config.vm.network :private_network, ip: "33.33.33.10"
    redis_config.vm.network :forwarded_port, guest: 8080, host: 8081

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
        }
      }
    end
  end

  config.vm.define :mysql do |mysql_config|
    mysql_config.vm.hostname = "mysql-opsworks-v"
    mysql_config.vm.box = "ubuntu_1204_chef_116"
    mysql_config.vm.box_url = "http://cdx-devops.s3.amazonaws.com/ubuntu_1204_chef_116.box"
    mysql_config.vm.network :private_network, ip: "33.33.33.10"
    mysql_config.vm.network :forwarded_port, guest: 8080, host: 8080

    mysql_config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "."
      chef.add_recipe "base-opsworks"
      chef.add_recipe "mysql::server_ec2"
      chef.json = {
      }
    end
  end
end
