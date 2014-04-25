include_recipe 'base-opsworks'
include_recipe 'base-opsworks::resque'
include_recipe 'corndog-chef::resque-deploy'
include_recipe 'corndog-chef::resque-service'
#commenting out until we are done testing
#include_recipe 'corndog-chef::resque-cron'
