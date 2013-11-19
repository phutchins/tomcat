# generic packages
install_packages = lambda do
  packages = %w(lsof colordiff nmap vim htop git sysstat xfsprogs)

  packages.each do |pkg|
    package pkg do
      action :install
    end
  end
end
