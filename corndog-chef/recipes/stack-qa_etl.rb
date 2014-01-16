run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'qa_etl'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'mongo3.dealermatch.biz:27017'
node.normal['corndog']['mongodb']['host_port_2'] = nil
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_production'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['cloudfront']['enabled'] = false
node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/eaa64a9f345'
node.normal['corndog']['solr']['master_host'] = 'index.websolr.com'
node.normal['corndog']['solr']['master_port'] = 80
node.normal['corndog']['solr']['master_path'] = '/solr/dc2f508b356'
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['marketing']['enabled'] = false
node.normal['corndog']['marketing']['url'] = nil

node.normal['corndog']['action_mailer']['default_url_options_host'] = 'qa_etl.dealermatch.com'
node.normal['corndog']['action_mailer']['delivery_method'] = ':smtp'
node.normal['corndog']['action_mailer']['perform_deliveries'] = true
node.normal['corndog']['action_mailer']['raise_delivery_errors'] = false
node.normal['corndog']['action_mailer']['smtp_settings']['user_name'] = 'stangreen'
node.normal['corndog']['action_mailer']['smtp_settings']['password'] = 'wholesalenet'
node.normal['corndog']['action_mailer']['smtp_settings']['domain'] = 'localhost.localdomain'
node.normal['corndog']['action_mailer']['smtp_settings']['address'] = 'smtp.sendgrid.net'
node.normal['corndog']['action_mailer']['smtp_settings']['port'] = '587'
node.normal['corndog']['action_mailer']['smtp_settings']['authentication'] = :plain
node.normal['corndog']['action_mailer']['smtp_settings']['enable_starttls_auto'] = true
node.normal['corndog']['action_mailer']['whitelist_interceptor'] = true

node.normal['corndog']['cde']['admin_password'] = 'abselectstart'
node.normal['corndog']['cde']['email_routing_domain'] = 'qa-etl.dealermatch.com'
node.normal['corndog']['aws']['image_bucket'] = 'cde-qa-etl-images'

node.normal['corndog']['salesforce']['enabled'] = false

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
