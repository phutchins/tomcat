require File.expand_path('../support/helpers', __FILE__)

describe 'collectd::client' do
  include Helpers::Collectd

  describe 'collectd::_install_from_package' do
    it 'installs collectd' do
      package('collectd').must_be_installed
    end

    it 'installs the correct version of collectd' do
      case node['platform_family']
      when 'debian'
        get_version = "dpkg-query -W -f='${Version}' collectd"
      when 'rhel'
        get_version = "rpm -q collectd --queryformat %{VERSION}"
      else
        get_version = "echo unsupported #{platform_family}, good luck."
      end
      actual = assert_sh(get_version)
      assert_equal node['collectd']['version'], actual if node['collectd']['version']
    end

  end
end
