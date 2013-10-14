name             'redis'
maintainer       'Cox Digital Exchange'
maintainer_email 'cdx-devops@manheim.com'
license          'All rights reserved'
description      'Installs/Configures redis'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

recipe 'default', 'does nothing'
recipe 'server', 'Installs / Configures Redis'

supports 'ubuntu'

