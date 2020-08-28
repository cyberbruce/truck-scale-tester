puts "Starting Scale"

require 'socket'

server = TCPServer.new ENV.fetch('PORT', 3000)
$stdout.sync = true
 
MAX = ENV.fetch('MAX', 100_000).to_f
INCREMENT = ENV.fetch('INCREMENT', 100).to_f
INTERVAL = ENV.fetch('INTERVAL', 0.25).to_f

loop do
    Thread.start(server.accept) do |client|
        print "\nStarting Connection\n"
        print "Connection received from: #{client.inspect}"  
        begin
            sign = 1
            n = 0.0
            loop do 
                "#{n}\r".chars.each do |c|
                    printf c
                    client.print c
                end
                sleep INTERVAL

                # bottom sleep extra
                if n == 0.0
                    sleep 2.0
                end
                #
                n += INCREMENT * sign
                if n > MAX   
                    n = MAX                  
                    sign = -1
                elsif n <= 0
                    sign = 1
                    n = 0
                end
            end
        rescue
            print "Closing connection!\n"
            client.close
        end       
    end
  end
 
    

   
 