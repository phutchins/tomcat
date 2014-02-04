node.normal['corndog']['stack'] = 'production'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['redis']['uri'] = nil
node.normal['corndog']['redis']['port'] = '6379'
node.normal['corndog']['mongodb']['host_port_1'] = 'cde-production.member2.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = 'cde-production.member3.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_3'] = nil
node.normal['corndog']['mongodb']['database'] = 'cde_production'
node.normal['corndog']['mongodb']['username'] = 'cdx_user'
node.normal['corndog']['mongodb']['password'] = 'carsrstillc00l'
node.normal['corndog']['mongodb']['identity_map_enabled'] = 'true'
node.normal['corndog']['mongodb']['consistency'] = ':strong'
node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://do4yd0ji84ogk.cloudfront.net'
node.normal['corndog']['solr']['host'] = '23.22.128.7'
node.normal['corndog']['solr']['port'] = 80
node.normal['corndog']['solr']['path'] = '/solr/a2e7ca6ba2a'
node.normal['corndog']['solr']['master_host'] = '23.22.128.7'
node.normal['corndog']['solr']['master_port'] = 80
node.normal['corndog']['solr']['master_path'] = '/solr/ce48a2afebb'
node.normal['corndog']['solr']['log_level'] = 'WARNING'

node.normal['corndog']['force_ssl'] = 'false'

node.normal['corndog']['marketing']['url'] = 'http://www3.dealermatch.com'

node.normal['corndog']['email_routing_domain'] = 'messages.dealermatch.com'

node.normal['corndog']['aws']['image_bucket'] = 'cde-images'

node.normal['corndog']['mixpanel']['token'] = '764ee859d87ccf7fa3add1dbd3b68af0'
node.normal['corndog']['mixpanel']['mobile_token'] = 'ad2faf77a73820161da4d7fe9c6bdeeb'

node.normal['corndog']['urbanairship']['application_key'] = 'ovzuP3xrRtaITIEbgeNVJw'
node.normal['corndog']['urbanairship']['application_secret'] = 'v24KJXUYTpabaV2QOi4wOA'
node.normal['corndog']['urbanairship']['master_secret'] = '-JsSRR_SSZGvh4wWws_fTQ'

node.normal['corndog']['recurly']['subdomain'] = 'dealermatch'
node.normal['corndog']['recurly']['api_key'] = 'eae1a4e9a30a4997bbb2c862fa304df6'
node.normal['corndog']['recurly']['js_key'] = 'c2d02fe9e08444c5a2c9c381c7b018e0'
node.normal['corndog']['recurly']['default_plan'] = 'monthly_a_web'

node.normal['corndog']['salesforce']['client_config']['host'] = 'login.salesforce.com'
node.normal['corndog']['salesforce']['robot_credentials']['username'] = 'cdx-bi@dealermatch.com'
node.normal['corndog']['salesforce']['unsubscribe_endpoint'] = 'https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8'

node.normal['corndog']['newrelic_app_name'] = 'production-ow'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
