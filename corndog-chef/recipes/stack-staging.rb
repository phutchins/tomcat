run_context.include_receipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'staging'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'cde-staging.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = nil
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_staging'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['mongodb']['identity_map_enabled'] = 'true'
node.normal['corndog']['mongodb']['consistency'] = ':strong'
node.normal['corndog']['cloudfront']['enabled'] = false
node.normal['corndog']['cloudfront']['site'] = 'https://staging-ey.dealermatch.biz'
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d37di6rf5nv9f5.cloudfront.net'
node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/90a76be5e41'
node.normal['corndog']['solr']['master_host'] = 'index.websolr.com'
node.normal['corndog']['solr']['master_port'] = 80
node.normal['corndog']['solr']['master_path'] = '/solr/2ffb7bfb331'
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['marketing']['enabled'] = false
node.normal['corndog']['marketing']['url'] = nil

node.normal['corndog']['action_mailer']['default_url_options_host'] = 'staging-ey.dealermatch.com'
node.normal['corndog']['action_mailer']['delivery_method'] = ':smtp'
node.normal['corndog']['action_mailer']['perform_deliveries'] = true
node.normal['corndog']['action_mailer']['raise_delivery_errors'] = false
node.normal['corndog']['action_mailer']['default_characterset'] = 'utf-8'
node.normal['corndog']['action_mailer']['smtp_settings']['user_name'] = 'stangreen'
node.normal['corndog']['action_mailer']['smtp_settings']['password'] = 'wholesalenet'
node.normal['corndog']['action_mailer']['smtp_settings']['domain'] = 'localhost.localdomain'
node.normal['corndog']['action_mailer']['smtp_settings']['address'] = 'smtp.sendgrid.net'
node.normal['corndog']['action_mailer']['smtp_settings']['port'] = '587'
node.normal['corndog']['action_mailer']['smtp_settings']['authentication'] = ':plain'
node.normal['corndog']['action_mailer']['smtp_settings']['enable_starttls_auto'] = true
node.normal['corndog']['action_mailer']['whitelist_interceptor'] = true

node.normal['corndog']['cde']['admin_password'] = 'abselectstart'
node.normal['corndog']['cde']['email_routing_domain'] = 'staging-ey.dealermatch.com'
node.normal['corndog']['aws']['image_bucket'] = 'cde-staging-images'

node.normal['corndog']['mixpanel']['token'] = '7d6cc1e88f3c7b32fd2c17dc4a9b5b2b'
node.normal['corndog']['mixpanel']['mobile_token'] = 'd7c84ac071f14ca51fbb74b86034ad39'
node.normal['corndog']['mixpanel']['async'] = true
node.normal['corndog']['mixpanel']['insert_js_last'] = true

node.normal['corndog']['recurly']['enabled'] = 'false'
node.normal['corndog']['recurly']['subdomain'] = 'dealermatch'
node.normal['corndog']['recurly']['api_key'] = 'eae1a4e9a30a4997bbb2c862fa304df6'
node.normal['corndog']['recurly']['js_key'] = 'c2d02fe9e08444c5a2c9c381c7b018e0'
node.normal['corndog']['recurly']['currency'] = 'USD'
node.normal['corndog']['recurly']['default_plan'] = 'monthly_a_web'

node.normal['corndog']['salesforce']['client_config']['host'] = 'test.salesforce.com'
node.normal['corndog']['salesforce']['client_config']['client_secret'] = '6556291173479883030'
node.normal['corndog']['salesforce']['client_config']['client_id'] = '3MVG9rFJvQRVOvk7G2JVJouG3aJz8IIToKNyI.At3Hbg_M.jHhJHork7_JB2tvkBn3fTrWJYtqx9WhnlH55wE'
node.normal['corndog']['salesforce']['client_config']['sobject_module'] = 'SFDC'
node.normal['corndog']['salesforce']['client_config']['debugging'] = 'true'
node.normal['corndog']['salesforce']['robot_credentials']['username'] = 'cdx-bi@dealermatch.com.offermsg'
node.normal['corndog']['salesforce']['robot_credentials']['password'] = 'D0nkeyC0rn!!g7gXEHjBTIf7sqsNLgHbijaY'
node.normal['corndog']['salesforce']['robot_id'] = '005d0000001VVK2AAO'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
