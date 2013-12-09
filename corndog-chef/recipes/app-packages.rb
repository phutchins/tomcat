# app configuration

packages =     %w[ imagemagick libmagickwand-dev htop ]
gem_packages = %w[ bluepill ]

packages.each do |p|
  package p do
    action :install
  end
end

gem_packages.each do |g|
  gem_package g do
    action :install
  end
end


