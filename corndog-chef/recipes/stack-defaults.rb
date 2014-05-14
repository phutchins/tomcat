stack = node.normal['corndog']['stack']
subdomain_prefix = stack.gsub('_', '-')

node.normal['corndog']['action_mailer']['default_url_options_host'] = "#{subdomain_prefix}.dealermatch.biz"
node.normal['corndog']['action_mailer']['smtp_settings']['user_name'] = 'stangreen'
node.normal['corndog']['action_mailer']['smtp_settings']['password'] = 'wholesalenet'
node.normal['corndog']['action_mailer']['smtp_settings']['domain'] = 'localhost.localdomain'
node.normal['corndog']['action_mailer']['smtp_settings']['address'] = 'smtp.sendgrid.net'
node.normal['corndog']['action_mailer']['smtp_settings']['port'] = '587'
node.normal['corndog']['action_mailer']['smtp_settings']['authentication'] = 'plain'
node.normal['corndog']['action_mailer']['smtp_settings']['enable_starttls_auto'] = 'true'

node.normal['corndog']['aws']['image_bucket'] = "cde-#{subdomain_prefix}-images"

# This doesn't work for anything but production. We might should check if its prod to set dot com else set dot biz. Or just leave it blank.
node.normal['corndog']['cloudfront']['asset_hosts'] = "https://#{subdomain_prefix}.dealermatch.biz"

node.normal['corndog']['deal_shield']['ftp']['folder'] = "Dealshield/#{stack}"

node.normal['corndog']['email_routing_domain'] = "#{subdomain_prefix}.dealermatch.biz"

node.normal['corndog']['marketing']['url'] = '/users/sign_in'

node.normal['corndog']['matchpro']['endpoint'] = 'https://matchpro-qa.dealermatch.biz/api/recommended_vehicles'
node.normal['corndog']['matchpro']['user'] = 'corndog@matchpro.com'
node.normal['corndog']['matchpro']['password'] = 'donkeycarsrc00l'

node.normal['corndog']['mixpanel']['token'] = '7d6cc1e88f3c7b32fd2c17dc4a9b5b2b'
node.normal['corndog']['mixpanel']['mobile_token'] = 'd7c84ac071f14ca51fbb74b86034ad39'

mongodb_username = 'cdx_user'
mongodb_password = 'carsrstillc00l'

node.normal['corndog']['mongodb']['host_port_2'] = nil
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['username'] = mongodb_username
node.normal['corndog']['mongodb']['password'] = mongodb_password

node.normal['corndog']['mongodb_archive']['host_port_2'] = nil
node.normal['corndog']['mongodb_archive']['username'] = mongodb_username
node.normal['corndog']['mongodb_archive']['password'] = mongodb_password

node.normal['corndog']['recurly']['subdomain'] = 'cdx-test'
node.normal['corndog']['recurly']['api_key'] = '60633d0d1f7e4e1b979cecbabe4ca65d'
node.normal['corndog']['recurly']['js_key'] = '0c017960e0914cea9a85548fc50a06eb'
node.normal['corndog']['recurly']['default_plan'] = 'monthly_a'

node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'

node.normal['corndog']['salesforce']['client_config']['host'] = 'test.salesforce.com'
node.normal['corndog']['salesforce']['robot_credentials']['username'] = 'cdx-bi@dealermatch.com.qa'

node.normal['corndog']['solr']['host'] = 'index.websolr.com'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['urbanairship']['application_key'] = 'Hhy_49_KROKPHm33h5ssFQ'
node.normal['corndog']['urbanairship']['application_secret'] = 'wGWe_o9KRcSoTDTIVf9w7A'
node.normal['corndog']['urbanairship']['master_secret'] = 'gn5yboSGQIWqduIxMFleVg'
