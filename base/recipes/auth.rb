node.normal['openldap']['basedn'] = 'dc=dealermatch,dc=biz'
node.normal['openldap']['server'] = 'ldap.dealermatch.biz'
node.normal['openldap']['tls_enabled'] = false
node.normal['openldap']['tls_checker'] = false
node.normal['openldap']['pam_password'] = 'md5'

include_recipe "openldap::auth"
