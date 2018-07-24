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

part of tedServer;


/** --------------------------------------------------------------------
*
*   isolate Entry/Exit point
*
------------------------------------------------------------------------- */

SendPort    rootMonitorIsolatePort;
ReceivePort serverMonitorIsolatePort;

void serverMonitorIsolateEntry(SendPort reply)
{
  print("TED serverMonitorIsolateEntry: monitor isolate Entry");

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  // Here we create a new singleton serverMonitorIsolate instance that listens for
  // socket management commands posted to the "serverMonitorIsolateEntry" Isolate
  // send port.

  serverMonitorIsolatePort = new ReceivePort();
  rootMonitorIsolatePort   = reply;

  serverMonitorIsolatePort.listen(new serverMonitorIsolate().createServerSession);

  rootMonitorIsolatePort.send(serverMonitorIsolatePort.sendPort);
  rootMonitorIsolatePort.send("start");
}


/** -------------------------------------------------------------------------
 *
 *  The monitorService class maintains the socketServer instances
 *
 *  Note: Even though this is implemented as a singleton - the singleton
 *        property is not global but is isolate specific. i.e. each isolate
 *        may have its own singleton instance. So we don't ever want to call
 *        this anywhere except in the root isolate.
 *
 ------------------------------------------------------------------------- */

class serverMonitorIsolate
{
  static final serverMonitorIsolate _Singleton = new serverMonitorIsolate._constructor();

  StreamController   _cmdStream;
  StreamController   _logStream;
  StreamController   _dataStream;

  SendPort           _rootPort;
  List<socketServer> _servers;

  isolatePoolMonitor _isolatePoolMonitor;
  int                _isolateCount = 8;

  Map<int,socketWorker> _connections = new Map<int, socketWorker>();


  /**
   *   Any attempts to construct a new instance gets the singleton in response
   */

  factory serverMonitorIsolate()
  {
    return _Singleton;
  }


  /**
   *  this constructor is used to generate the singleton instance that is
   *  used globally
   *
   */

  serverMonitorIsolate._constructor()
  {
    // create the server list

    _servers = new List<socketServer>();

    // This stream controller is used by all child socketServer instances to communicate
    // status information back to this monitor object.

    _dataStream = new StreamController.broadcast();

    _cmdStream  = new StreamController.broadcast();
    _cmdStream.stream.listen(commandHandler);

    _logStream  = new StreamController();
    _logStream.stream.listen(logDataStream);

    // Create a pool of worker isolates - note that there is a one-to-one relation
    // between isolates and threads so we don't need to create more than the CPU can
    // run concurrently.

    // Work units should be as brief as possible and use blocking internally to allow
    // concurrency if necessary.

    _isolatePoolMonitor = new isolatePoolMonitor.create(_isolateCount, _dataStream, _logStream.sink, isolatePoolMonitor.TYPE_ROUNDROBIN );
  }


  /** --------------------------------------------------------------------
  *
  *   Isolate Port createServerSession
  *   Messages mostly come here from the root isolate "main" function
  *
  ------------------------------------------------------------------------*/

  void createServerSession(packet)
  {
    if(GDSocketMonitor) print('serverMonitorIsolate: Creating new Socket Server:');

    String reply;

    if(packet is SendPort)
    {
      _rootPort = packet;
    }

    else switch(packet.cmd)
    {
      case "create":

          // Note that invalid parms to connect will result in a synchronous error (throw) that will
          // not be managed by the asynchronous Future

          try
          {
            _servers.add(new socketServer.connect(_dataStream, _cmdStream.sink, _logStream.sink, packet));

            reply = "serverMonitorIsolate says: server created successfully on ${packet.address} port:${packet.port}";
          }
          catch(e)
          {
            reply = "serverMonitorIsolate says: ERROR: server creation failed:" + e.toString();
          }

          break;
    }

    if (reply != null && rootMonitorIsolatePort != null)
                            rootMonitorIsolatePort.send(reply);

  }



  /** -----------------------------------------------------------------------------
   *
   * Command handler informs the isolatePool of changes to the client connections
   *
   */
  void commandHandler(Map cmd)
  {
    var key = cmd.keys;

    switch(key.first)
    {
      // addClient 'key' has a socketWorker as the map 'Value'

      case 'addClient':

        // The isolatePool uses the socketWorker to update the protocol state
        // data after a workerIsolate has finished processing it.

        _isolatePoolMonitor.addClient(cmd['addClient']);

        _connections[cmd['addClient'].hashCode] = cmd['addClient'];

        _logStream.add("Connection Count: ${_connections.length}");
        
        if(GDConnectionCounter) print("Connection Count (inc): ${_connections.length}");

        break;

      // removeClient 'key' has a socketWorker as the map 'Value'

      case 'removeClient':

        // Here we remove the client and enable it for GC

        _isolatePoolMonitor.removeClient(cmd['removeClient']);

        _connections.remove(cmd['removeClient'].hashCode);

        _logStream.add("Connection Count: ${_connections.length}");
        
        if(GDConnectionCounter) print("Connection Count (dec): ${_connections.length}");
        
        break;
    }
  }


  /** --------------------------------------------------------------------
  *
  *   Emit the log data coming from the socketServer instances
  *
  ------------------------------------------------------------------------*/

  void logDataStream(evt)
  {
    if(GDlogStream) print(evt);
  }


}




