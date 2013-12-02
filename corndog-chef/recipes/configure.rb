# Includes all recipes to be run during Opsworks Configure lifecycle event

include_recipe 'base-opsworks'
include_recipe 'corndog-chef::prod'
include_recipe 'corndog-chef::app'
