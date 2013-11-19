install_collectd = lambda do
  include_recipe 'collectd::client_graphite'

  if node['collectd']['logging_enabled']
    collectd_plugin 'logfile' do
      options :log_level => 'info',
              :file => '/var/log/collectd.log',
              :time_stamp => true
    end
  end
 
  if node['collectd']['plugin-swap']
    collectd_plugin 'swap'
  end

  %w(ntpd cpu load disk memory).each do |plug|
    collectd_plugin plug
  end

  collectd_plugin 'syslog' do
    options :log_level => 'info',
            :notify_level => 'warning'
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
end

install_collectd.call
