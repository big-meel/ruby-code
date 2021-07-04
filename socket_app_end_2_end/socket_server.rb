require 'socket'

class Server
  def initialize(socket_address, socket_port)
    @server_socket = TCPServer.open(socket_port, socket_address)

    @connection_details = Hash.new
    @connection_clients = Hash.new

    # @connection_details[:server]  = @server_socket
    @connection_details[:clients] = @connection_clients

    puts 'Started server......'
    run_server
  end

  def run_server
    loop {
      client_connection = @server_socket.accept
      Thread.start(client_connection) do |conn| # open thread for each accepted connection
        conn_name = conn.gets.chomp.to_sym
        if(@connection_details[:clients][conn_name] != nil) # avoid connection if user exists
          conn.puts "Username exists"
          conn.puts "quit"
          conn.kill self
        end

        puts "Connection established #{conn_name} => #{conn}"
        @connection_details[:clients][conn_name] = conn
        conn.puts "Connection established successfully #{conn_name} => #{conn}, you may continue......"

        establish_chatting(conn_name, conn) #allow chatting

      end
    }.join
  end

  def establish_chatting(username, connection)
    loop do
      message = connection.gets.chomp
      puts @connection_details[:clients]
      (@connection_details[:clients]).keys.each do |client|
        @connection_details[:clients][client].puts "#{username} : #{message}"
      end
    end
  end
end

Server.new(8080, "localhost")
