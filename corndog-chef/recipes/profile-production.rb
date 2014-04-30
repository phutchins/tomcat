# This file includes all logic for production-like environments

profile = 'production'
rails_env = 'production'
node.normal['corndog']['profile'] = profile
# Monitoring
#node.override['collectd']['graphite_prefix'] = "#{node['corndog']['stack']}.#{node['corndog']['node_type']}.#{node[:opsworks][:instance][:aws_instance_id]}"

# Retrieve attributes from node object
# Required attributes (add some logic here to fail if not assigned)
mongodb_database = node['corndog']['mongodb']['database']
mongodb_username = node['corndog']['mongodb']['username']
mongodb_password = node['corndog']['mongodb']['password']
redis_port = node['corndog']['redis']['port']

# Additional attributes
mongodb_host_port_2 ||= node['corndog']['mongodb']['host_port_2']
mongodb_host_port_3 ||= node['corndog']['mongodb']['host_port_3']

# Attributes from the OpsWorks Environment
if !node['opsworks']['layers']['redis']['instances'].nil?
  redis_uri = 'redis://'
  node['opsworks']['layers']['redis']['instances'].each do |instance|
    Chef::Log.info("Adding instance '#{instance[0]}' to Redis URI with hostname '#{instance[1]['public_dns_name']}'")
    redis_uri << "#{instance[1]['public_dns_name']}:#{redis_port},"
  end
end
redis_uri.chop!
# If override is not nil, use that
redis_uri = node['corndog']['redis']['uri'] || redis_uri
Chef::Log.info("Redis URI: #{redis_uri}")

node.normal['corndog']['dotenv'] = {
  'RAILS_ENV' => rails_env,
  'MONGODB_HOST_PORT_1' => node['corndog']['mongodb']['host_port_1'],
  'MONGODB_HOST_PORT_2' => mongodb_host_port_2,
  'MONGODB_HOST_PORT_3' => mongodb_host_port_3,
  'MONGODB_DATABASE' => mongodb_database,
  'MONGODB_USERNAME' => mongodb_username,
  'MONGODB_PASSWORD' => mongodb_password,
  'REDIS_URI' => redis_uri,
  'SOLR_HOST' => node['corndog']['solr']['host'],
  'SOLR_PORT' => node['corndog']['solr']['port'],
  'SOLR_PATH' => node['corndog']['solr']['path'],
  'SOLR_LOG_LEVEL' => node['corndog']['solr']['log_level'],
  'CLOUDFRONT_ASSET_HOSTS' => node['corndog']['cloudfront']['asset_hosts'],
  'CDE_MARKETING_URL' => node['corndog']['marketing']['url'],
  'ACTION_MAILER_DEFAULT_URL_OPTIONS_HOST' => node['corndog']['action_mailer']['default_url_options_host'],
  'ACTION_MAILER_SMTP_SETTINGS_USER_NAME' => node['corndog']['action_mailer']['smtp_settings']['user_name'],
  'ACTION_MAILER_SMTP_SETTINGS_PASSWORD' => node['corndog']['action_mailer']['smtp_settings']['password'],
  'ACTION_MAILER_SMTP_SETTINGS_DOMAIN' => node['corndog']['action_mailer']['smtp_settings']['domain'],
  'ACTION_MAILER_SMTP_SETTINGS_ADDRESS' => node['corndog']['action_mailer']['smtp_settings']['address'],
  'ACTION_MAILER_SMTP_SETTINGS_PORT' => node['corndog']['action_mailer']['smtp_settings']['port'],
  'ACTION_MAILER_SMTP_SETTINGS_AUTHENTICATION' => node['corndog']['action_mailer']['smtp_settings']['authentication'],
  'ACTION_MAILER_SMTP_SETTINGS_ENABLE_STARTTLS_AUTO' => node['corndog']['action_mailer']['smtp_settings']['enable_starttls_auto'],
  'CDE_EMAIL_ROUTING_DOMAIN' => node['corndog']['email_routing_domain'],
  'DEAL_SHIELD_FTP_FOLDER' => node['corndog']['deal_shield']['ftp']['folder'],
  'AWS_IMAGE_BUCKET' => node['corndog']['aws']['image_bucket'],
  'MATCHPRO_ENDPOINT' => node['corndog']['matchpro']['endpoint'],
  'MATCHPRO_USER' => node['corndog']['matchpro']['user'],
  'MATCHPRO_PASSWORD' => node['corndog']['matchpro']['password'],
  'MIXPANEL_TOKEN' => node['corndog']['mixpanel']['token'],
  'MIXPANEL_MOBILE_TOKEN' => node['corndog']['mixpanel']['mobile_token'],
  'URBANAIRSHIP_APPLICATION_KEY' => node['corndog']['urbanairship']['application_key'],
  'URBANAIRSHIP_APPLICATION_SECRET' => node['corndog']['urbanairship']['application_secret'],
  'URBANAIRSHIP_MASTER_SECRET' => node['corndog']['urbanairship']['master_secret'],
  'RECURLY_SUBDOMAIN' => node['corndog']['recurly']['subdomain'],
  'RECURLY_API_KEY' => node['corndog']['recurly']['api_key'],
  'RECURLY_JS_KEY' => node['corndog']['recurly']['js_key'],
  'RECURLY_DEFAULT_PLAN' => node['corndog']['recurly']['default_plan'],
  'SALESFORCE_CLIENT_CONFIG_HOST' => node['corndog']['salesforce']['client_config']['host'],
  'SALESFORCE_ROBOT_CREDENTIALS_USERNAME' => node['corndog']['salesforce']['robot_credentials']['username'],
  'STACK' => node['corndog']['stack']
}

# Load defaults for all Corndog hosts and environments
run_context.include_recipe 'corndog-chef::default'
# Create the .env file from the attributes we've set here
run_context.include_recipe 'corndog-chef::dotenv'
