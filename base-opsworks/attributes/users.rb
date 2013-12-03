#default['authorization']['sudo']['groups'] = ['devops', 'ubuntu', 'admin']
#default['authorization']['sudo']['users'] = ['ubuntu', 'phutchins', 'jgerry', 'deploy']
#default['authorization']['sudo']['passwordless'] = true

default['authorization']['sudo']['sudoers_defaults'] = [
  'env_reset',
  'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' ]
default['authorization']['sudo']['include_sudoers_d'] = true
