require 'socket'
#tada
class Server

	def initialize(host, port)
		web_server = TCPServer.open(host, port)
		puts "Server started on #{host}:#{port} ..."

			loop do                                             # Server runs forever
  client = web_server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets.chomp) && !line.empty?  # Read the request and collect it until it's empty
  	lines << line
  end

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

def read_request_path(my_lines)
	if /^[A-Z]+\s+\/(\S++)/ =~ my_lines[0]       
		request_path = $1                       

	end
end 

end

s = Server.new('localhost', 2000).read_request_path