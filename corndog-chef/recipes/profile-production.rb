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
mongodb_session_options ||= node['corndog']['mongodb']['session_options']
cde_marketing_url ||= node['corndog']['marketing']['url']
newrelic_app_name = node['corndog']['newrelic_app_name'] || node['corndog']['stack']

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
  'REDIS_URL' => redis_uri,
  'SOLR_HOST' => node['corndog']['solr']['host'],
  'SOLR_PORT' => node['corndog']['solr']['port'],
  'SOLR_PATH' => node['corndog']['solr']['path'],
  'SOLR_LOG_LEVEL' => node['corndog']['solr']['log_level'],
  'SOLR_MASTER_HOST' => node['corndog']['solr']['master_host'],
  'SOLR_MASTER_PORT' => node['corndog']['solr']['master_port'],
  'SOLR_MASTER_PATH' => node['corndog']['solr']['master_path'],
  'CLOUDFRONT_ENABLED' => node['corndog']['cloudfront']['enabled'],
  'CLOUDFRONT_SITE' => node['corndog']['cloudfront']['site'],
  'CLOUDFRONT_ASSET_HOSTS' => node['corndog']['cloudfront']['asset_hosts'],
  'CDE_MARKETING_ENABLED' => node['corndog']['marketing']['enabled'],
  'CDE_MARKETING_URL' => cde_marketing_url,
  'FORCE_SSL' => node['corndog']['force_ssl'],
  'ACTION_MAILER_DEFAULT_URL_OPTIONS_HOST' => node['corndog']['action_mailer']['default_url_options_host'],
  'ACTION_MAILER_DELIVERY_METHOD' => node['corndog']['action_mailer']['delivery_method'],
  'ACTION_MAILER_PERFORM_DELIVERIES' => node['corndog']['action_mailer']['perform_deliveries'],
  'ACTION_MAILER_RAISE_DELIVERY_ERRORS' => node['corndog']['action_mailer']['raise_delivery_errors'],
  'ACTION_MAILER_DEFAULT_CHARACTERSET' => node['corndog']['action_mailer']['default_characterset'],
  'ACTION_MAILER_SMTP_SETTINGS_USER_NAME' => node['corndog']['action_mailer']['smtp_settings']['user_name'],
  'ACTION_MAILER_SMTP_SETTINGS_PASSWORD' => node['corndog']['action_mailer']['smtp_settings']['password'],
  'ACTION_MAILER_SMTP_SETTINGS_DOMAIN' => node['corndog']['action_mailer']['smtp_settings']['domain'],
  'ACTION_MAILER_SMTP_SETTINGS_ADDRESS' => node['corndog']['action_mailer']['smtp_settings']['address'],
  'ACTION_MAILER_SMTP_SETTINGS_PORT' => node['corndog']['action_mailer']['smtp_settings']['port'],
  'ACTION_MAILER_SMTP_SETTINGS_AUTHENTICATION' => node['corndog']['action_mailer']['smtp_settings']['AUTHENTICATION'],
  'ACTION_MAILER_SMTP_SETTINGS_ENABLE_STARTTLS_AUTO' => node['corndog']['action_mailer']['smtp_settings']['ENABLE_STARTTLS_AUTO'],
  'ACTION_MAILER_WHITELIST_INTERCEPTOR' => node['corndog']['action_mailer']['whitelist_interceptor'],
  'AWS_IMAGE_BUCKET' => node['corndog']['aws']['image_bucket'],
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
  'SALESFORCE_UNSUBSCRIBE_ENDPOINT' => node['corndog']['salesforce']['unsubscribe_endpoint'],
  'STACK' => node['corndog']['stack'],
  'NEWRELIC_APP_NAME' => newrelic_app_name
}

# Load defaults for all Corndog hosts and environments
run_context.include_recipe 'corndog-chef::default'
# Create the .env file from the attributes we've set here
run_context.include_recipe 'corndog-chef::dotenv'
