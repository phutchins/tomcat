execute "reindex vehicles and dealerships" do
  user = 'deploy'
  command "cd /srv/www/corndog/current ; bundle exec rails r -e production 'ReindexWorker.index_dealerships ; ReindexWorker.index_vehicles'"
end


