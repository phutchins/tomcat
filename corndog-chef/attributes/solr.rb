default[:solr][:max_time] = 5000

default[:solr][:replication][:enabled] = true
default[:solr][:replication][:replicate_after] = ['commit', 'startup']
default[:solr][:replication][:conf_files] = "schema.xml,stopwords.txt"
default[:solr][:replication][:poll_interval] = "00:00:60"
