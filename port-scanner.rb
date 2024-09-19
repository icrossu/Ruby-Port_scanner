require 'socket'
require 'timeout'
require 'optparse'

def port_scanner(target, ports)
  ports.each do |port|
    s = nil
    begin
      Timeout::timeout(3) do
        s = Socket.new(:INET, :STREAM)
        remote_addr = Socket.sockaddr_in(port, target)
        
        begin
          s.connect_nonblock(remote_addr)
        rescue IO::WaitWritable
          IO.select(nil, [s], nil, 3)
          puts "Port #{port} on #{target} is open"
        rescue Errno::EINPROGRESS
          IO.select(nil, [s], nil, 3)
          puts "Port #{port} on #{target} is open"
        rescue Errno::ECONNREFUSED
          puts "Port #{port} on #{target} is closed"
        rescue Errno::ETIMEDOUT
          puts "Port #{port} timed out to connect"
        ensure
          s.close if s
        end
      end
    rescue Timeout::Error
      puts "Port #{port} timed out to connect"
    end
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = <<-BANNER
Usage: 'ruby portscanner.rb [options]'
version 1.0
By: IcaroSSU
Github: github.com/icaroSSU

This script is a tool for pentesting, specifically for scanning ports on a target.
If you need help using the script, use -h.

Available Options:

-h, --help                         Show this help menu
-tTARGET, --target=TARGET          Specify the target URL or IP
-pPORTS, --ports=PORTS             Comma-separated list of ports to scan

BANNER

  opts.on("-tTARGET", "--target=TARGET", "Specify the target URL or IP") do |target|
    options[:target] = target
  end

  opts.on("-pPORTS", "--ports=PORTS", "Comma-separated list of ports to scan") do |ports|
    options[:ports] = ports.split(',').map(&:to_i)
  end
end.parse!

if options[:target]
  puts "Target: #{options[:target]}"
else
  puts "No target specified"
end

if options[:ports]
  puts "Ports: #{options[:ports].join(', ')}"
else
  puts "No ports specified"
  options[:ports] = [21, 23, 53, 3306, 1433, 22, 80, 443, 3389, 8080, ] 
end

target = options[:target]
ports = options[:ports]

port_scanner(target, ports)
