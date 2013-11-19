# Sets hostname to node['fqdn'] from chef
node.normal['set_fqdn'] = node.name
include_recipe 'hostname'
