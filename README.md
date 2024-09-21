   # Code Explanation
   
   ### 1. Libraries
   
  ## 1.1 Sockets
  
The code was written entirely in pure Ruby, designed to perform analysis and port scanning of a URL or IP. The scheme behind this tool consists of using the 'Sockets' library found in most programming languages.

require 'socket'  # (import socket library)

   ### 1.2 Timeout
 You can notice the appearance of the 'Timeout' library, which was added to set a specific time limit for the execution of a block of code. The default specified is 2 seconds. The purpose of using this function is to ensure that when the code reaches a time limit, it doesn't cause congestion in the data structure where the ports are stored, preventing or even causing malfunctions in port scanning.

require 'timeout'  # (import timeout library)

   ### 1.3 Optparse
The 'Optparse' library is used to add options to the code, making it executable from the terminal where the code is run. The purpose of this library in the code is to optimize and enhance usability. For instance, options like '-p, -t, -h' provide specific functionality to the code, such as adding ports and specific paths for port scanning.

require 'optparse'  # (import optparse library)

   ### 2.0 Logic

   ### Loop over the ports:
Iterates over each port in the ports list.

   ### Timeout Block:
Sets a 2-second time limit for each connection attempt. If the connection is not established within this time, a Timeout::Error is raised.

   ### Socket Creation:
Socket.new(:INET, :STREAM) creates a new TCP socket (stream) for network communication.

  ### Remote Address Setup:
Socket.sockaddr_in(port, target) creates a socket address structure for connecting to the specified IP/URL and port.

### Connection Attempt:
s.connect_nonblock(remote_addr) attempts to connect to the remote address in a non-blocking way.

### Exception Handling:
IO::WaitWritable: The connection is still in progress and requires more time. It uses IO.select to wait until the socket is ready for writing. If the socket is ready, the port is considered open.
Errno::EINPROGRESS: Indicates that the operation is in progress. It uses IO.select to wait until the connection is established.
Errno::ECONNREFUSED: The connection was refused by the target machine. The port is closed.
Errno::ETIMEDOUT: The connection timed out. The port could not be reached within the time limit.
 
### Socket Closure:
The socket s is closed in the ensure block, ensuring that the resource is released even if an exception occurs.

# Tradutions

[texto do link]()

