
require File.expand_path('../support/helpers',__FILE__)

describe 'collectd::client_graphite' do
  include Helpers::Collectd

  it 'creates graphite plugin configuration' do
    if node['collectd']['version'] =~ /5\.\d+/
      conf = "write_graphite.conf"
    else
      conf = "carbon_writer.conf"
    end

    file("#{node['collectd']['plugconf_dir']}/#{conf}").must_exist
  end
end
