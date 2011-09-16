class Post < ActiveRecord::Base
#  after_update :trigger_node
  
  def trigger_node
    require 'socket'
    hostname = '127.0.0.1'
    port = 8001
    TCPSocket.open(hostname, port) {|s|
      s.send "GET / HTTP/1.0\r\n\r\n s", 0
      p s.read
    }
  end
end
