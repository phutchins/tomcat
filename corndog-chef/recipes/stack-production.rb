node.normal['corndog']['profile'] = 'production'
node.normal['corndog']['stack'] = 'production'
run_context.include_recipe 'corndog-chef::stack-defaults'

# This file includes all attributes that apply only to the devopstest stack

# Assign environmentals to node
node.normal['corndog']['action_mailer']['default_url_options_host'] = 'www.dealermatch.com'

node.normal['corndog']['aws']['image_bucket'] = 'cde-images'

node.normal['corndog']['cloudfront']['asset_hosts'] = 'https://dgos3g1ufzdpi.cloudfront.net'

node.normal['corndog']['deal_shield']['ftp']['folder'] = 'Dealshield'

node.normal['corndog']['email_routing_domain'] = 'messages.dealermatch.com'

node.normal['corndog']['marketing']['url'] = 'http://www3.dealermatch.com'

node.normal['corndog']['matchpro']['endpoint'] = 'https://matchpro.dealermatch.com/api/recommended_vehicles'

node.normal['corndog']['mixpanel']['token'] = '764ee859d87ccf7fa3add1dbd3b68af0'
node.normal['corndog']['mixpanel']['mobile_token'] = 'ad2faf77a73820161da4d7fe9c6bdeeb'

node.normal['corndog']['mongodb']['host_port_1'] = 'cde-production.member2.mongolayer.com:27017'
node.normal['corndog']['mongodb']['host_port_2'] = 'cde-production.member3.mongolayer.com:27017'
node.normal['corndog']['mongodb']['database'] = 'cde_production'

node.normal['corndog']['mongodb_archive']['host_port_1'] = 'cde-production-archive.m0.mongolayer.com:27017'
node.normal['corndog']['mongodb_archive']['host_port_2'] = 'cde-production-archive.m1.mongolayer.com:27017'
node.normal['corndog']['mongodb_archive']['database'] = 'cde_production_archive'

node.normal['corndog']['recurly']['subdomain'] = 'dealermatch'
node.normal['corndog']['recurly']['api_key'] = 'eae1a4e9a30a4997bbb2c862fa304df6'
node.normal['corndog']['recurly']['js_key'] = 'c2d02fe9e08444c5a2c9c381c7b018e0'
node.normal['corndog']['recurly']['default_plan'] = 'monthly_a_web'

node.normal['corndog']['salesforce']['client_config']['host'] = 'login.salesforce.com'
node.normal['corndog']['salesforce']['robot_credentials']['username'] = 'cdx-bi@dealermatch.com'

node.normal['corndog']['solr']['path'] = '/solr/ce48a2afebb'

node.normal['corndog']['urbanairship']['application_key'] = 'ovzuP3xrRtaITIEbgeNVJw'
node.normal['corndog']['urbanairship']['application_secret'] = 'v24KJXUYTpabaV2QOi4wOA'
node.normal['corndog']['urbanairship']['master_secret'] = '-JsSRR_SSZGvh4wWws_fTQ'

run_context.include_recipe "corndog-chef::profile-#{node['corndog']['profile']}"
