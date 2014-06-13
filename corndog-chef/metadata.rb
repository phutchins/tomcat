name             'corndog-chef'
maintainer       'Cox Digital Exchange'
maintainer_email 'philip.hutchins@dealermatch.com'
license          'All rights reserved'
description      'Configures and Deploys Corndog'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version     '0.0.55'

depends "sar"
depends "s3_file"
depends "base-opsworks"
depends "redis"
depends "chef-solr"
