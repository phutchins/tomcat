default[:solr][:install_method] = 'from_archive'
default[:solr][:version] = '3.6.1'
default[:solr][:download_url] = 'https://archive.apache.org/dist/lucene/solr/3.6.1/'
default[:solr][:archive_name] = 'apache-solr-3.6.1.tgz'
default[:solr][:extract_dir_name] = 'apache-solr-3.6.1'
default[:solr][:war_name] = 'apache-solr-3.6.1.war'

default[:solr][:max_time] = 5000

default[:solr][:replication][:enabled] = true
default[:solr][:replication][:replicate_after] = ['commit', 'startup']
default[:solr][:replication][:conf_files] = "schema.xml,stopwords.txt"
default[:solr][:replication][:poll_interval] = "00:00:60"

