include_recipe 'base-opsworks::resque'
include_recipe 'corndog-chef::resque-deploy'
include_recipe 'corndog-chef::resque-service'
include_recipe 'corndog-chef::resque-cron'
