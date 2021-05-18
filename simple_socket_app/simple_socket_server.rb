require 'socket'

puts "Starting the Server..................."

#Server listens on port 3000
server = TCPServer.open(3000)

# Server runs forever
loop {                        
  # Establish client connection
  client_connection = server.accept

  # Thread will handle multiple connections at once
  Thread.start(client_connection) do |connection| 
    connection.puts(Time.now) # Send the time to the client
    connection.puts("Closing the connection with #{client_connection}")
    connection.close      # Disconnect Server
  end
}