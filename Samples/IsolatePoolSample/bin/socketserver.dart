//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Kevin Willows
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

part of isolatePoolSample;


/**
 * This represents a listening socket - when users connect a transactional socket
 * will be created in the socketWorker to manage the data stream
 */
class socketServer
{
  ServerSocket      _listener;

  StreamSink        _cmdStream;
  StreamSink        _logStream;
  StreamController  _dataStream;

  socketDescription _socketDesc;

  Map<SendPort,String> _workers     = new Map<SendPort,String>();


  socketServer.connect(StreamController dataStream, StreamSink cmdStream, StreamSink logStream, socketDescription socketDesc)
  {
    Future<ServerSocket> SocketServer;

    _dataStream = dataStream;
    _cmdStream  = cmdStream;
    _logStream  = logStream;
    _socketDesc = socketDesc;

    // Create a server and bind it to an address and port number.
    // Note: We can get synchonous failures here if parameters are invalid (e.g. port #) which
    //       bypasses the Future so we need to use try/catch
    try
    {
      SocketServer = ServerSocket.bind(socketDesc.address, socketDesc.port);

      // This is called when a connection is received.

      SocketServer.then(onBind);
      SocketServer.catchError(onError);
    }
    catch(e)
    {
      _logStream.add("socketServer: CONNECT FAILED" + e.toString());

      throw(e);
    }
  }


  void onBind(ServerSocket socketServer)
  {
    _listener = socketServer;

    _logStream.add('socketServer: Server is now listening on port ${_socketDesc.address} : ${_socketDesc.port}');

    socketServer.listen(onConnect, onError:onError, onDone:onDone);
  }


  void onError(message)
  {
    _listener.close();

    _logStream.add('socketServer: Server connection has failed on port ${_socketDesc.port}');
    _logStream.add('socketServer: SocketServer Error...');
  }


  void onDone()
  {

    _logStream.add('socketServer: Server connection closed on port ${_socketDesc.port}');
    _logStream.add('socketServer: Shutdown');

    _logStream.add('socketServer: Exiting SocketServer...');
  }


  void onConnect(Socket socket)
  {
    socketWorker worker = new socketWorker.onConnect(_dataStream, _cmdStream, _logStream, socket);
  }
}












