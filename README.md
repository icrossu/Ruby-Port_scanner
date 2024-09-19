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



  
