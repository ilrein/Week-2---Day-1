require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

class Server

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started

def read_request_path(my_lines)
    if /^[A-Z]+\s+\/(\S++)/ =~ my_lines[0]       # We check the first line of the request to see
      request_path = $1                       # if it matches the "METHOD /path HTTP/1.1" format
#else 
 # request_path = "index.html"
    end
end 

loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets.chomp) && !line.empty?  # Read the request and collect it until it's empty
  	lines << line
  end
  puts lines                                        # Output the full request to stdout

  filename = read_request_path(lines)
  filename = filename.nil? ? "index.html" : filename

  response = if File.exists?(filename)
    File.read(filename)
  else
    "File Not Found"

  end

  client.puts(response)
  client.close 

end 
end

s = Server.new
#s.
start
