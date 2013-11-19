#!/bin/env ruby
require 'syslog'               # For logging to syslog
require 'socket'               # Get sockets from stdlib
server = TCPServer.new(5425)   # Socket to listen on port 2000
loop do
  Thread.start(server.accept) do |client|
    resp = "<html>Running chef-client!</html>"
    headers = ["HTTP/1.1 200 OK",
               "Date: Tue, 14 Dec 2010 10:48:45 GMT",
               "Server: Ruby",
               "Content-Type: text/html; charset=iso-8859-1",
               "Content-Length: #{resp.length}\r\n\r\n"].join("\r\n")
    client.puts headers          # Send the time to the client
    client.puts resp
    client.close                 # Disconnect from the client
    `sudo killall -USR1 chef-client`
    Syslog.open('KickIt', Syslog::LOG_PID, Syslog::LOG_LOCAL5) { |s| s.info 'Kicking chef-client' }
  end
end
