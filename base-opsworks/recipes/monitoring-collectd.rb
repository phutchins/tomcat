fqdn = node[:fqdn]
fqdn.slice! ".localdomain" || node[:fqdn]
#node.normal['collectd']['graphite_prefix'] = "#{node[:opsworks][:stack][:name]}.#{fqdn}"
node.normal['collectd']['graphite_prefix'] = node[:opsworks][:stack][:name]

include_recipe 'collectd'
include_recipe 'collectd::client_graphite'

collectd_plugin 'logfile' do
  only_if { node['collectd']['logging_enabled'] }
  options :log_level => 'info',
          :file => '/var/log/collectd.log',
          :time_stamp => true
end

if node['collectd']['plugin-swap']
  collectd_plugin 'swap'
end

if node['collectd']['plugin-ntpd']
  collectd_plugin 'ntpd'
end

%w(cpu load disk memory).each do |plug|
  collectd_plugin plug
end

collectd_plugin 'syslog' do
  options :log_level => 'info'
end

collectd_plugin 'tcpconns' do
  options :listening_ports => true
end

collectd_plugin 'sshd' do
  type 'tail'
  options :file => {
    '/var/log/auth.log' => {
      :instance => 'auth',
      :match => [
        {
          :regex => '\\<sshd[^:]*: Invalid user [^ ]+ from\\>',
          :d_s_type => 'CounterInc',
          :type => 'counter',
          :instance => 'sshd-invalid_user'
        }
      ]
    }
  }
end
