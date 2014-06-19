# Setting the default install method
default[:solr][:install_method] = 'from_archive'

# Global settings
default[:solr][:data_dir] = '/var/lib/solr/data'

# For package install
default[:solr][:package_version] = "1.4.1+dfsg1-2ubuntu2"

# For archive download and install
default[:solr][:version] = "4.8.1"
default[:solr][:download_url] = "https://archive.apache.org/dist/lucene/solr/4.8.1/"
default[:solr][:archive_name] = "solr-4.8.1.tgz"
default[:solr][:war_name] = "solr-4.8.1.war"
default[:solr][:config_dir] = "/var/solr/conf"
default[:solr][:base_dir] = "/var/solr"
default[:solr][:max_time] = 5000

default[:solr][:multicore][:enabled] = false

default[:solr][:replication][:enabled] = false
default[:solr][:replication][:poll_interval] = "00:00:60"
default[:solr][:replication][:master_url] = "localhost"
default[:solr][:port] = 8080
