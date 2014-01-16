packages =     %w[ libsqlite3-dev ]

packages.each do |p|
  package p do
    action :install
  end
end
