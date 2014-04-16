# app configuration

packages =     %w[ imagemagick libmagickwand-dev htop openjdk-7-jdk zip ]
gem_packages = %w[ bluepill god ]

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


