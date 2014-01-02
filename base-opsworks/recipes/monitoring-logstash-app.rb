node.override[:logstash] = {
  :agent => {
    :inputs => [
      :file => {
        :type => "rails",
        :path => [ "/srv/www/corndog/shared/log/<%= stack_name %>.log" ],
        :tags => [ 'rails' ],
        :multiline => {
          :pattern => "^\s",
          :what    => "previous"
        }
      },
      :file => {
        :type => "unicorn",
        :path => [ '/srv/www/corndog/shared/log/unicorn.log' ],
        :tags => [ 'unicorn' ]
      },
      :file => {
        :type => "unicorn",
        :path => [ '/data/corndog/shared/log/unicorn.stderr.log' ],
        :tags => [ 'unicorn', 'error' ]
      },
      :file => {
        :type => "unicorn",
        :path => [ '/data/corndog/shared/log/unicorn.stdout.log' ],
        :tags => [ 'unicorn', 'access' ]
      },
      :file => {
        :type => "deploy",
        :path => [ '/home/deploy/*.log' ],
        :tags => [ 'deploy' ]
      },
      :file => {
        :type => "nginx-error",
        :path => [ '/var/log/nginx/corndog.error.log' ],
        :tags => [ 'nginx','error' ]
      },
      :file => {
        :type => "nginx-access",
        :path => [ '/var/log/nginx/corndog.access*.log' ],
        :tags => [ 'nginx','access' ]
      }
    ],
    :filters => [
      { :grep => {
          :match => { '@message' => '^$' },
          :drop => true
      } },
      { :condition => 'if "rails" in [tags]',
        :block => [
          :multiline => {
            :pattern => "^\s|Processing|Completed|Redirected",
            :what => 'previous'
          }
        ]
      },
      { :condition => 'if "nginx" in [tags] and "access" in [tags]',
        :block => [
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
        ]
      },
      { :mutate => {
          :replace => [ "source_host", "<%= stack_name %>-<%= host_role %>" ],
          :add_tag => [ "<%= stack_name %>-appserver" ]
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
