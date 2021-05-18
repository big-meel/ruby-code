require 'socket'

socket = TCPSocket.open($HOSTNAME, 3000) # hostname of server, in actual app this can added to a constant variable such as $HOSTNAME

puts "Starting the Client........."
while message = socket.gets         # Read lines from the socket
  puts message.chomp
end

puts "Closing the Client........"
socket.close                         # Close the socket