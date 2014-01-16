run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'devopstest'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'c0.cde-qa.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = nil
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_production'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['mongodb']['identity_map_enabled'] = 'true'
node.normal['corndog']['mongodb']['consistency'] = ':strong'
node.normal['corndog']['cloudfront']['enabled'] = true
node.normal['corndog']['cloudfront']['site'] = 'https://qa.dealermatch.com'
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d32lfm0jr6byac.cloudfront.net'
node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/e3cb33a92d8'
node.normal['corndog']['solr']['master_host'] = nil
node.normal['corndog']['solr']['master_port'] = nil
node.normal['corndog']['solr']['master_path'] = nil
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['marketing']['enabled'] = false
node.normal['corndog']['marketing']['url'] = '/users/sign_in'

node.normal['corndog']['action_mailer']['default_url_options_host'] = 'qa-ey.dealermatch.com'
node.normal['corndog']['action_mailer']['delivery_method'] = ':smtp'
node.normal['corndog']['action_mailer']['perform_deliveries'] = true
node.normal['corndog']['action_mailer']['raise_delivery_errors'] = false
node.normal['corndog']['action_mailer']['default_characterset'] = 'utf-8'
node.normal['corndog']['action_mailer']['smtp_settings']['user_name'] = 'stangreen'
node.normal['corndog']['action_mailer']['smtp_settings']['password'] = 'wholesalenet'
node.normal['corndog']['action_mailer']['smtp_settings']['domain'] = 'localhost.localdomain'
node.normal['corndog']['action_mailer']['smtp_settings']['address'] = 'smtp.sendgrid.net'
node.normal['corndog']['action_mailer']['smtp_settings']['port'] = '587'
node.normal['corndog']['action_mailer']['smtp_settings']['authentication'] = false
node.normal['corndog']['action_mailer']['smtp_settings']['enable_starttls_auto'] = true
node.normal['corndog']['action_mailer']['whitelist_interceptor'] = false

node.normal['corndog']['cde']['admin_password'] = 'Sr1r@cha'
node.normal['corndog']['cde']['email_routing_domain'] = 'qa-ey.dealermatch.com'
node.normal['corndog']['aws']['image_bucket'] = 'cde-images'

node.normal['corndog']['recurly']['subdomain'] = nil
node.normal['corndog']['recurly']['api_key'] = nil
node.normal['corndog']['recurly']['js_key'] = nil
node.normal['corndog']['recurly']['currency'] = nil
node.normal['corndog']['recurly']['default_plan'] = nil

node.normal['corndog']['salesforce']['client_config']['host'] = 'test.salesforce.com'
node.normal['corndog']['salesforce']['client_config']['client_secret'] = '6556291173479883030'
node.normal['corndog']['salesforce']['client_config']['client_id'] = '3MVG9rFJvQRVOvk7G2JVJouG3aJz8IIToKNyI.At3Hbg_M.jHhJHork7_JB2tvkBn3fTrWJYtqx9WhnlH55wE'
node.normal['corndog']['salesforce']['client_config']['sobject_module'] = 'SFDC'
node.normal['corndog']['salesforce']['client_config']['debugging'] = 'true'
node.normal['corndog']['salesforce']['robot_credentials']['username'] = 'cdx-bi@dealermatch.com'
node.normal['corndog']['salesforce']['robot_credentials']['password'] = 'D0nkeyC0rn!!g7gXEHjBTIf7sqsNLgHbijaY'
node.normal['corndog']['salesforce']['robot_id'] = '005d0000001VVK2AAO'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
