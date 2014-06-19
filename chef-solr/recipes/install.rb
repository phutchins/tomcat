node.normal[:tomcat][:java_options] = "${JAVA_OPTS} -Xmx#{node['solr']['tomcat']['xmx']} -Xms#{node['solr']['tomcat']['xms']} -Djava.awt.headless=true -XX:+UseConcMarkSweepGC"

include_recipe 'tomcat'

case node[:solr][:install_method]
when 'from_archive'
  include_recipe 'chef-solr::from_archive'
when 'from_package'
  include_recipe 'chef-solr::from_package'
else
  Chef::Log.info("You must set an install method via node[:solr][:install_method]")
end
