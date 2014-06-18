# Setting the default install method
default[:solr][:install_method] = 'from_archive'

# For package install
default[:tomcat][:version] = "6.0.35-1ubuntu3.4"
default[:solr][:package_version] = "1.4.1+dfsg1-2ubuntu2"

# For archive download and install
default[:solr][:version] = "4.8.1"
default[:solr][:download_url] = "https://archive.apache.org/dist/lucene/solr/4.8.1/"
default[:solr][:archive_name] = "solr-4.8.1.tgz"
default[:solr][:war_name] = "solr-4.8.1.war"
default[:solr][:base_dir] = "/var/solr"
default[:solr][:max_time] = 5000

default[:solr][:multicore][:enabled] = false

default[:solr][:replication][:enabled] = false
default[:solr][:replication][:poll_interval] = "00:00:60"
default[:solr][:port] = 8080
