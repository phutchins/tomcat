default[:logstash][:install_on_envs] = [ 'production','qa','devopstest','ab1','ab2' ]
default[:logstash][:install_on_role] = [ 'app','app_master','util' ]
default[:logstash][:jarfile] = 'logstash-1.2.1-flatjar.jar'

