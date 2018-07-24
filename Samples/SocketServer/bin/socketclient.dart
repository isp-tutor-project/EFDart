library socketClient;

import 'dart:io';
import 'dart:async';
import 'dart:convert';

Socket connection;

void main()
{
  // Create a server and bind it to an address and port number.

  Future clientSocket = Socket.connect("127.0.0.1", 12003);

  // This is called when a connection is received.

  clientSocket.then(onConnect, onError:onError);

  singleIntInput();
  //singleCharInput();
}

void onError(message)
{
  if(connection != null)
      connection.close();

  print('SocketClient Error...');
  exit(1);
}

void onDone()
{
  print('Exiting SocketClient...');
}

void onConnect(Socket socket)
{
  print('new connection: $socket');

  connection = socket;

  socket.listen(onMessage);

}


void onMessage(List message)
{
  String str = new String.fromCharCodes(message);

  print('new message: $str - $message');

//  connection.write('echo');

  if(message[0] == 3)
      connection.close();
}

void singleCharInput()
{

  Stream<List<int>> inputStream = stdin;

  inputStream
    .transform(new AsciiDecoder())
    .listen(
      (String line) {
        print('Read ${line.length} bytes from stream: ' + line);
        connection.write(line);
      },
      onDone: () { print('file is now closed'); },
      onError: (e) { print(e.toString()); });

}

void singleIntInput()
{

  Stream<List<int>> inputStream = stdin;

  inputStream
    .listen(
      (List<int> line)
      {
        print('Read ${line.length} bytes from stream: ' + line.toString());
        connection.write(line);
      },
      onDone: () { print('file is now closed'); },
      onError: (e) { print(e.toString()); });

}

void multiCharInput()
{

  Stream<List<int>> inputStream = stdin;

  inputStream
    .transform(new AsciiDecoder())
    .listen(
      (String line) {
        print('Read ${line.length} bytes from stream: ' + line);
      },
      onDone: () { print('file is now closed'); },
      onError: (e) { print(e.toString()); });

}
