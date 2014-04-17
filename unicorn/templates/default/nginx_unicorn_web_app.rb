upstream unicorn_corndog {
 server unix:/srv/www/corndog/shared/sockets/unicorn.sock fail_timeout=0;
}

server {
  listen 80;
  server_name corndog <%= @hostname %>;
  access_log /var/log/nginx/corndog.access.log main;
  error_log  /var/log/nginx/corndog.error.log error;

  keepalive_timeout 5;

  root /srv/www/corndog/current/public/;


  location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;

    # If you don't find the filename in the static files
    # Then request it from the unicorn server
    if (!-f $request_filename) {
      proxy_pass http://unicorn_corndog;
      break;
    }
  }

  location /nginx_status {
    stub_status on;
    access_log off;
    allow 127.0.0.1;
    deny all;
  }

  # production redirects
  if ( $host ~ "^(.*).dealermatch.(com|biz)" ) {
    rewrite ^/try$ http://www2.dealermatch.com/try permanent;
    rewrite ^/try/$ http://www2.dealermatch.com/try permanent;
  }

  # marketing redirects
  rewrite "^/(?i)an1" http://www2.dealermatch.com/an1 redirect;
  rewrite "^/(?i)an2" http://www2.dealermatch.com/an2 redirect;
  rewrite "^/(?i)an3" http://www2.dealermatch.com/an3 redirect;
  rewrite "^/(?i)an4" http://www2.dealermatch.com/an4 redirect;
  rewrite "^/(?i)an5" http://www2.dealermatch.com/an5 redirect;
  rewrite "^/(?i)ar1" http://www2.dealermatch.com/ar1 redirect;
  rewrite "^/(?i)ar2" http://www2.dealermatch.com/ar2 redirect;
  rewrite "^/(?i)ar3" http://www2.dealermatch.com/ar3 redirect;
  rewrite "^/(?i)ar4" http://www2.dealermatch.com/ar4 redirect;
  rewrite "^/(?i)ar5" http://www2.dealermatch.com/ar5 redirect;
  rewrite "^/(?i)ucd1" http://www2.dealermatch.com/ucd1 redirect;
  rewrite "^/(?i)ucd2" http://www2.dealermatch.com/ucd2 redirect;
  rewrite "^/(?i)ucd3" http://www2.dealermatch.com/ucd3 redirect;
  rewrite "^/(?i)ucd4" http://www2.dealermatch.com/ucd4 redirect;
  rewrite "^/(?i)ucd5" http://www2.dealermatch.com/ucd5 redirect;
  rewrite "^/(?i)ucn1" http://www2.dealermatch.com/ucn1 redirect;
  rewrite "^/(?i)ucn2" http://www2.dealermatch.com/ucn2 redirect;
  rewrite "^/(?i)ucn3" http://www2.dealermatch.com/ucn3 redirect;
  rewrite "^/(?i)ucn4" http://www2.dealermatch.com/ucn4 redirect;
  # trivial pursuit redirects
  rewrite "^/(?i)trivia" http://www2.dealermatch.com/l/15952/2013-12-12/262npt redirect;
  rewrite "^/(?i)40K" http://www2.dealermatch.com/l/15952/2013-12-12/262npt redirect;
  # NADA
  rewrite "^/(?i)rules" http://www2.dealermatch.com/rules redirect;
  rewrite "^/(?i)nada" http://www2.dealermatch.com/nada redirect;
  rewrite "^/(?i)cbt1" http://www2.dealermatch.com/cbt1 redirect;
  # other
  rewrite "^/(?i)compare" http://www2.dealermatch.com/compare redirect;
  rewrite "^/(?i)seattle" http://www2.dealermatch.com/seattle redirect;
  rewrite "^/(?i)vw" http://www2.dealermatch.com/vw redirect;
  rewrite "^/(?i)ng" http://www2.dealermatch.com/ng redirect;
  rewrite "^/(?i)dd16" http://www2.dealermatch.com/dd16 redirect;
  rewrite "^/(?i)drivingsales" http://www2.dealermatch.com/drivingsales redirect;
  rewrite "^/(?i)connect" http://www2.dealermatch.com/connect redirect;
  rewrite "^/(?i)namad" http://www2.dealermatch.com/namad redirect;
  rewrite "^/(?i)leedombhph2014" http://www2.dealermatch.com/leedombhph2014 redirect;

  # remove unwanted requests
  location ~* .*Microsoft-Server-ActiveSync.* {
    return 404;
  }

  location ~* .*autodiscover.xml.* {
    return 404;
  }

  # Auction Genius integration
  location /genius {
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass  https://dealermatch.auctiongenius.net/;
    proxy_cookie_domain  www.dealermatch.com  /dealermatch.auctiongenius.net;
    # buffer settings
    proxy_buffering on;
    proxy_buffers 128 4k;
    proxy_redirect default;

  }

  # redirects
  if ( $host ~* "^dealermatch.com$" ) {
    rewrite ^(.*)$ https://www.dealermatch.com$1 permanent;
  }

  if ( $host ~ "^(.*).dealermatch.(com|biz)" ) {
    rewrite ^/events-m$ http://www2.dealermatch.com/events-m permanent;
    rewrite ^/mobileapp$ http://www2.dealermatch.com/mobileapp permanent;
    rewrite ^/readytogo-m$ http://www2.dealermatch.com/readytogo-m permanent;
  }

  # generic proxy for images
  location ^~ /proxy {
    resolver 8.8.8.8;
    location ~ "^/proxy/(.*)/(.*)" {
      proxy_set_header X-Forwarded-Host $host;
      proxy_set_header X-Forwarded-Server $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_redirect off;
      proxy_pass http://$1/$2;
    }
  }

  error_page 500 502 503 504 /500.html;
  location = /500.html {
    root /srv/www/corndog/current/public/;
  }
}

proxy_buffer_size 128k;
proxy_buffers 4 256k;
proxy_busy_buffers_size 256k;

