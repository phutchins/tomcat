if node['chef-client']['enable-daemon']
  if platform?('ubuntu')
    node.normal['chef_client']['init_style'] = 'upstart'
  elsif platform?("mac_os_x")
    # Do something OSX related
  end

  include_recipe "chef-client::service"
#  include_recipe "runit"
#  include_recipe "chef-client::runit_service"
end
