// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library chat_server;

import 'dart:io';
import 'dart:isolate';
import 'dart:async';

import 'chat/chatservice.dart';

const DEFAULT_PORT = 8888;
const DEFAULT_HOST = "127.0.0.1";

void main() 
{
  // For profiling stopping after some time is convenient. Set
  // stopAfter for that.
  int stopAfter;

  var serverPort = spawnFunction(startChatServer);
  
  ServerMain serverMain =
      new ServerMain.start(serverPort, DEFAULT_HOST, DEFAULT_PORT);

  // Start a shutdown timer if requested.
  if (stopAfter != null) 
  {
    new Timer(new Duration(seconds: stopAfter), serverMain.shutdown);
  }
}


// This is the thread entry point for the chat service thread
// It is spawned to 

void startChatServer() 
{
  var server = new chatServerIsolate();
  
  server.init();
  port.receive(server.dispatch);
}


class ServerMain 
{
  ReceivePort _statusPort;  // Port for receiving messages from the server.
  SendPort    _serverPort;  // Port for sending messages to the server.
  
  ServerMain.start(SendPort serverPort,
                   String hostAddress,
                   int tcpPort)
      : _statusPort = new ReceivePort(),
        _serverPort = serverPort 
  {
    // We can only guess this is the right URL. At least it gives a
    // hint to the user.
    print('Server starting http://${hostAddress}:${tcpPort}/');
    _start(hostAddress, tcpPort);
  }

  void _start(String hostAddress, int tcpPort) 
  {
    // Handle status messages from the server.
    _statusPort.receive((var message, SendPort replyTo) 
    {
      String status = message.message;
      print("Received status: $status");
    });

    // Send server start message to the server.
    var command = new chatServerCommand.start(hostAddress, tcpPort);
    _serverPort.send(command, _statusPort.toSendPort());
  }

  void shutdown() 
  {
    // Send server stop message to the server.
    _serverPort.send(new chatServerCommand.stop(), _statusPort.toSendPort());
    _statusPort.close();
  }

}



