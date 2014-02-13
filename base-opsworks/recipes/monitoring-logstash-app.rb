# Pull this from somewhere in opsworks attrs
node.default['corndog']['host_role'] = 'rails_app'
node.default['corndog']['profile'] = 'production'

stack_name = node['corndog']['stack']
profile_name = node['corndog']['profile']
host_role = node['corndog']['host_role']

node.override[:logstash] = {
  :patterns => {
    :rails => {
      :RAILS3_LOG => '(?m)Started %{WORD:verb} "%{URIPATHPARAM:request}" for %{IPORHOST:clientip} at (?<timestamp>%{YEAR:year}-%{MONTHNUM:month}-%{MONTHDAY:day} %{HOUR:hour}:%{MINUTE:minute}:%{SECOND:second} %{ISO8601_TIMEZONE:timezone})\s*Processing by (?<controller>[^#]+)#(?<action>\w+) as (?<format>\S+)(?:\n  Parameters: %{DATA:params}\n)?%{DATA}Completed %{NUMBER:response}%{DATA} in %{NUMBER:totalms}ms \(Views: %{NUMBER:viewms}ms \| ActiveRecord: %{NUMBER:activerecordms}ms%{GREEDYDATA}'
    }
  },
  :agent => {
    :inputs => [
      { :file => {
        :type => "rails",
        :path => [ "/srv/www/corndog/shared/log/#{profile_name}.log" ],
        :tags => [ 'rails' ]
      } },
      { :file => {
        :type => "unicorn",
        :path => [ '/srv/www/corndog/shared/log/unicorn.stderr.log' ],
        :tags => [ 'unicorn', 'error' ]
      } },
      { :file => {
        :type => "unicorn",
        :path => [ '/srv/www/corndog/shared/log/unicorn.stdout.log' ],
        :tags => [ 'unicorn', 'access' ]
      } },
      { :file => {
        :type => "nginx-error",
        :path => [ '/var/log/nginx/corndog.error.log' ],
        :tags => [ 'nginx','error' ]
      } },
      { :file => {
        :type => "nginx-access",
        :path => [ '/var/log/nginx/corndog.access.log' ],
        :tags => [ 'nginx','access' ]
      } }
    ],
    :filters => [
      { :condition => 'if "rails" in [tags]',
        :block => {
          :multiline => {
            :pattern => '^\s',
            :what => 'previous'
          },
          :multiline => {
            :pattern => "^\s|Processing|Completed|Redirected",
            :what => 'previous'
          }
      } },
      { :condition => 'if "nginx" in [tags] and "access" in [tags]',
        :block => {
          :grok => {
            :match => [
              'message',
              '%{IPORHOST:clientip} %{USER:ident} %{USER:auth} \[%{HTTPDATE:timestamp}\] "(?:%{WORD:verb} %{NOTSPACE:request}(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})" %{NUMBER:response} (?:%{NUMBER:bytes}|-) %{QS:referrer} %{QS:agent} %{QS:forwardedfor} %{NUMBER:timing}'
            ]
          },
          :geoip => {
            :source => 'clientip',
            :add_field => [ "coords", "%{geoip.longitude},%{geoip.latitude}" ]
          }
      } },
      { :mutate => {
          :add_tag => [ "#{stack_name}", "#{host_role}" ]
      } }
    ],
    :outputs => [
      :redis => {
        :host => 'logs.dealermatch.biz',
        :port => 16379,
        :data_type => "list",
        :key => "logstash"
      }
    ]
  }
}
