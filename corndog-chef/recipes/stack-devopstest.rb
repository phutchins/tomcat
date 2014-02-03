node.normal['corndog']['stack'] = 'devopstest'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'cde-prod2.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = 'cde-prod2.m1.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_production'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['mongodb']['identity_map_enabled'] = 'true'
node.normal['corndog']['mongodb']['consistency'] = ':strong'
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://d2tb02q5zn0zzy.cloudfront.net'
node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/8c328dc5a19'
node.normal['corndog']['solr']['master_host'] = 'index.websolr.com'
node.normal['corndog']['solr']['master_port'] = 80
node.normal['corndog']['solr']['master_path'] = '/solr/bdada2584a2'
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['marketing']['enabled'] = false
node.normal['corndog']['marketing']['url'] = 'http://www3.dealermatch.com'

node.normal['corndog']['action_mailer']['default_url_options_host'] = 'www.dealermatch.com'
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
node.normal['corndog']['cde']['email_routing_domain'] = 'test-ow.dealermatch.com'
node.normal['corndog']['aws']['image_bucket'] = 'cde-images'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
