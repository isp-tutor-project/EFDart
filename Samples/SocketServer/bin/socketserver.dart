library SocketServer;

import 'dart:io';
import 'dart:async';

part "transactionSocket.dart";

ServerSocket      listener;
Socket            connection;
transactionSocket client;

void main()
{
  // Create a server and bind it to an address and port number.
  Future<ServerSocket> SocketServer = ServerSocket.bind("127.0.0.1", 12003);

  // This is called when a connection is received.
  SocketServer.then(onBind);
}

void onBind(ServerSocket socketServer)
{
  print('SocketServer Listening...');

  listener = socketServer;

  socketServer.listen(onConnect, onError:onError, onDone:onDone);
}

void onError(message)
{
  listener.close();

  print('SocketServer Error...');
}

void onDone()
{
  connection.close();

  print('Exiting SocketServer...');
}

void onConnect(Socket socket)
{
  client = new transactionSocket.onConnect(socket);
}
