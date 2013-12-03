include_recipe 'sudo'

sudo 'devops' do
  user  "%devops"
  nopasswd  true
end

sudo 'ubuntu' do
  user "ubuntu"
  nopasswd true
end

sudo 'admin' do
  user "%admin"
end

sudo 'root' do
  user "root"
end

sudo 'phutchins' do
  user "phutchins"
  nopasswd true
end

sudo 'jgerry' do
  user "jgerry"
  nopasswd true
end
