# Explicação do código

   ## 1. Bibliotecas  

### 1.1 Sockets

 O codigo foi criado inteiramente com a linguagem pura do Ruby, destinada a realizar análise e escaneamento de portas de um URL ou IP. O esquema por trás dessa ferramenta, consiste na usuabilidade da biblioteca de 'Sockets' contida na maioria das linguagens. 

 require 'sockets' (importar biblitoteca sockets)

### 1.2 Timeout
 É possível observar a aparição da biblioteca 'Timeout' a mesma foi colocada com a proposta e o papel central de definir um limite especifico de tempo para cada execução de um bloco de código, onde o padrão especificado foi de 2 segundos.
 A utilidade e finalidade da utilização dessa função, é justamente para que quando o código tenha um limite de tempo atingido, não cause um cogestionamento na estrutura de dados onde está guardado as portas, impedindo e até causando mal funcionamento no escaneamento das portas.

 require 'timeout' (importar biblioteca timeout)

 ### 1.3 Optaster
  A biblioteca 'Optaster' é uma biblioteca direcionada a colocar opções no código, podendo assim, serem executadas a partir do terminal onde o código for executado. A finalidade dessa biblioteca no código, é justamente otimização e acessibilidade na utilização do código, isto é, a adição de opções como '-p, -t, -h' fornecem diferencial especifico na funcionalidade do código, a adição de portas e trajetos especificos para o escaneamento de portas.

  require 'optaster' (importar biblioteca optaster)

  ## 2.0 Lógica
  
   ### Loop sobre as portas:
Itera sobre cada porta na lista ports.

  ### Bloco Timeout:
Define um tempo limite de 2 segundos para cada tentativa de conexão. Se a conexão não for estabelecida dentro desse tempo, um Timeout::Error será levantado.

  ### Criação do Socket:
Socket.new(:INET, :STREAM) cria um novo socket TCP (stream) para comunicação de rede.

  ### Configuração do Endereço Remoto:
Socket.sockaddr_in(port, target) cria uma estrutura de endereço de socket para a conexão com o IP/URL e a porta especificados.

  ### Tentativa de Conexão:
s.connect_nonblock(remote_addr) tenta conectar ao endereço remoto de forma não bloqueante.

  ### Tratamento de Exceções:
IO::WaitWritable: A conexão ainda está em andamento e precisa de mais tempo. Usa IO.select para esperar até que o socket esteja pronto para escrita. Se o socket estiver pronto, a porta é considerada aberta.
Errno::EINPROGRESS: Indica que a operação está em progresso. Usa IO.select para esperar até que a conexão seja estabelecida.
Errno::ECONNREFUSED: A conexão foi recusada pela máquina alvo. A porta está fechada.
Errno::ETIMEDOUT: O tempo de conexão expirou. A porta não pôde ser alcançada no tempo limite.

  ### Fechamento do Socket:
O socket s é fechado no bloco ensure, que garante que o recurso seja liberado mesmo se ocorrer uma exceção.

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
