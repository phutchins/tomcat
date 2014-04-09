# Pull this from somewhere in opsworks attrs
node.default['corndog']['host_role'] = 'rails_app'
node.default['corndog']['profile'] = 'production'

stack_name = node['corndog']['stack']
profile_name = node['corndog']['profile']
host_role = node['corndog']['host_role']

directory "/var/log/nginx" do
  owner 'www-data'
  group 'root'
  mode 0755
end

script "make logs readable" do
  interpreter "bash"
  user "root"
  cwd "/var/log"
  code "chmod 664 /var/log/nginx/*"
end

node.override[:logstash] = {
  :patterns => {
    :rails => {
      :RAILS3_LOG => '(?m)Started %{WORD:verb} "%{URIPATHPARAM:request}" for %{IPORHOST:clientip} at (?<timestamp>%{YEAR:year}-%{MONTHNUM:month}-%{MONTHDAY:day} %{HOUR:hour}:%{MINUTE:minute}:%{SECOND:second} %{ISO8601_TIMEZONE:timezone})\\s*Processing by (?<controller>[^#]+)#(?<action>\\w+) as (?<format>\\S+)(?:\\n  Parameters: %{DATA:params}\\n)?%{DATA}Completed %{NUMBER:response}%{DATA} in %{NUMBER:totalms}ms \\(Views: %{NUMBER:viewms}ms \\| ActiveRecord: %{NUMBER:activerecordms}ms%{GREEDYDATA}'
    }
  },
  :agent => {
    :inputs => [
      { :file => {
          :type => "catchall",
          :path => [ '/srv/www/corndog/shared/log/*.log' ],
          :exclude => [ "#{profile_name}.log", "unicorn*log", "salesforce*",
                        "resque*.log", "mail_delivery.log", "newrelic*",
                        "cron*", "bluepill*" ],
          :tags => [ 'catchall' ]
      } },
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
          :type => "salesforce_offer_thread",
          :path => [ '/srv/www/corndog/shared/log/salesforce_offer_thread_monitor.log' ],
          :tags => [ 'salesforce','offer_thread' ]
      } },
      { :file => {
          :type => "resque",
          :path => [ '/srv/www/corndog/shared/log/resque*.log' ],
          :tags => [ 'resque' ]
      } },
      { :file => {
          :type => "mail_delivery",
          :path => [ '/srv/www/corndog/shared/log/mail_delivery.log' ],
          :tags => [ 'mail_delivery' ]
      } },
      { :file =>{
          :type => "nginx-error",
          :path => [ '/var/log/nginx/*error*.log' ],
          :tags => [ 'nginx','error' ]
      } },
      { :file => {
          :type => "nginx-access",
          :path => [ '/var/log/nginx/*access*.log' ],
          :tags => [ 'nginx','access' ]
      } },
      { :file => {
          :type => "deploy",
          :path => [ '/var/lib/aws/opsworks/chef/*.log' ],
          :tags => [ 'deploy','chef' ]
      } }
    ],
    :filters => [
#      { :grok => {
          #:match => [ 'message' ,"^$" ],
          #:drop_if_match => true
#      } },

      { :condition => 'if "rails" in [tags]',
        :block => {
          #:grok => {
            #:match => [ "message", "%{RAILS3_LOG}" ]
          #}
          :multiline => {
            :pattern => "^\\s|Processing|Completed|Redirected",
            :what => "previous"
          }
        } },

      { :condition => 'if [type] == "salesforce_offer_thread"',
        :block => {
          :grok => {
            :match => [ "message", "\\[%{TIMESTAMP_ISO8601:timestamp}\\] \\[%{LOGLEVEL:log_level}\\] \\[%{DATA:message}\\] \\[%{NUMBER:occurrences}\\]" ]
          }
        } },

      { :condition => 'if "nginx" in [tags] and "access" in [tags]',
        :block => {
          :grok => {
            :match => [ 'message', '%{IPORHOST:clientip} %{USER:ident} %{USER:auth} \\[%{HTTPDATE:timestamp}\\] \"(?:%{WORD:verb} %{NOTSPACE:request}(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})\" %{NUMBER:response} (?:%{NUMBER:bytes}|-) %{QS:referrer} %{QS:agent} %{QS:forwardedfor} %{NUMBER:timing}' ]
          },
          :date => {
            :match => [ "timestamp", "dd/MMM/YYYY:HH:mm:ss Z" ],
            :add_tag => "ts"
          }
        } },

      { :condition => 'if "nginx" in [tags] and "error" in [tags]',
        :block => {
          :grok => {
            :match => [ 'message', '%{GREEDYDATA:timestamp} \\[%{DATA:loglevel}\\] %{GREEDYDATA:errmsg}' ]
          },
          :date => {
            :match => [ "timestamp", "YYYY/MM/dd HH:mm:ss" ],
            :add_tag => "ts"
          }
        } },

      { :condition => 'if [type] == "deploy"',
        :block => {
          :grok => {
            :match => [ 'message', '\\[%{TIMESTAMP_ISO8601:timestamp}\\] %{DATA:level}: %{GREEDYDATA:msg}' ]
          },
          :date => {
            :match => [ "timestamp", "ISO8601" ],
            :add_tag => "ts"
          }
        } },

      { :mutate => {
          :add_tag => [ "#{stack_name}", "#{host_role}" ]
      } }
    ],
    :outputs => [
      :redis => {
        :host => 'logstash-redis.dealermatch.biz',
        :port => 16379,
        :data_type => "list",
        :key => "logstash"
      }
    ]
  }
}
