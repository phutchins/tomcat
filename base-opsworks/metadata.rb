name			"base-opsworks"
description		"Installs the basics for all DealerMatch Opsworks Chef Nodes"
maintainer		"Philip Hutchins"
maintainer_email 	"philip.hutchins@dealermatch.com"
long_description 	IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          	"0.0.3"

depends 'collectd'
depends 'openssl'
depends 'logstash'
depends 'sar'
