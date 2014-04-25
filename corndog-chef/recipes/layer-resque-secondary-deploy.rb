include_recipe 'base-opsworks'
include_recipe 'base-opsworks::resque'
include_recipe 'corndog-chef::resque-deploy'
# Commenting out until we're done testing
#include_recipe 'corndog-chef::resque-cron'
