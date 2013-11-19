name			"base"
description		"Installs the basics for all DealerMatch Chef Nodes"
maintainer		"Philip Hutchins"
maintainer_email 	"philip.hutchins@dealermatch.com"
long_description 	IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          	"0.0.8"

depends "chef-client"
depends "kickit"
depends "hostname"
depends "users"
depends "sudo"
depends "collectd"
depends "openldap"
