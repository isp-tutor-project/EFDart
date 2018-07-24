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

class socketWorker
{

  DateTime          _connectTime;

  int               _guid;
  static int        _uniqueVal = 0;

  Socket            _xactSocket;

  StreamSink        _cmdStream;
  StreamSink        _logStream;
  StreamController  _dataStream;

  protocolUnknown   _protocol;
  bool              _protocolPending = false;

  workQueue         queue = new workQueue();


  socketWorker.onConnect(StreamController dataStream, StreamSink cmdStream, StreamSink logStream, Socket socket)
  {
    _connectTime = new DateTime.now();

    _guid = _connectTime.millisecondsSinceEpoch + _uniqueVal++;

    _protocol = new protocolUnknown(_guid);

    _cmdStream  = cmdStream;
    _logStream  = logStream;
    _dataStream = dataStream;

    _xactSocket = socket;
    _xactSocket.transform(UTF8.decoder).listen(processClientMessage, onError:errorManager, onDone:doneManager);

    _logStream.add('socketWorker: Transaction Socket Open: ${_xactSocket.remoteHost} + ident: ${_guid.toString()}');

    _cmdStream.add({'addClient': this});
    _cmdStream.add({'addQueue' : this.queue});
  }


  int get guid
  {
    return _guid;
  }

  protocolUnknown get protocol
  {
    return _protocol;
  }

  void set protocol(protocolUnknown updated)
  {
    _protocol = updated;
  }


  void errorManager(message)
  {
    _logStream.add('socketWorker: Transaction Socket Error: : ${_xactSocket.remoteHost} + ident: ${_guid.toString()}');

    _xactSocket.close();

    _cmdStream.add({'removeQueue' : this.queue});
    _cmdStream.add({'removeClient': this});
  }


  void doneManager()
  {
    _logStream.add('socketWorker: Transaction Socket Closed: : ${_xactSocket.remoteHost} + ident: ${_guid.toString()}');

    _xactSocket.close();

    _cmdStream.add({'removeQueue' : this.queue});
    _cmdStream.add({'removeClient': this});
  }


  void processClientMessage(message)
  {
    // note message is a Uint8List

    workPacket work = new workPacket(message);

    // Work units are dispensed differently depending upon the queueing method

    if(isolatePool.type == isolatePool.TYPE_ROUNDROBIN)
    {
      // special processing so that the protocol is determined before proceeding with further
      // operations

      switch(_protocol.id)
      {
        case protocolUnknown.PROTOCOL_UNKNOWN:

              // Until the protocol is determined we don't allow other packets to proceed.
              // Once the protocol is defined it will manage the concurrency

              // On the first pass ProtocolPending is false we don't allow more than one packet
              // to proceed until the protocol has been identified.

              if(!_protocolPending)
              {
                _protocolPending = true;
              }
              else
              {
                queue.pause();
              }
              queue.add(work);

              _dataStream.add("wakeup");
              break;

        case protocolUnknown.PROTOCOL_MONITOR_A:

              _cmdStream.add({'monitorCommand': work});

              break;

        default:
              queue.add(work);

              _dataStream.add("wakeup");

              break;
      }
    }

    else
    {
      _dataStream.add(work);
    }

    //_logStream.add('socketWorker: new message: $str on socket: $_id');
  }

  void reply()
  {
    //print('socketWorker: ${protocol.reply}');

    _xactSocket.write(protocol.reply);
  }

}






