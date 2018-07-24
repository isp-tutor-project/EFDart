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

class socketWorker
{

  DateTime          _connectTime;

  int               _guid;
  static int        _uniqueVal = 0;

  Socket            _xactSocket;

  StreamSink        _cmdStream;
  StreamSink        _logStream;
  StreamController  _dataStream;

  sessionStatus     _session;

  String            _aggBuffer = "";          // Aggregation buffer for messages larger than 1024bytes - where the underlying
                                              // Socket Stream splits messages
  workQueue         queue = new workQueue();


  socketWorker.onConnect(StreamController dataStream, StreamSink cmdStream, StreamSink logStream, Socket socket)
  {
    try 
    {
      _connectTime = new DateTime.now();
  
      _guid = _connectTime.millisecondsSinceEpoch + _uniqueVal++;
  
      _session = new sessionStatus(_guid);
  
      _cmdStream  = cmdStream;
      _logStream  = logStream;
      _dataStream = dataStream;
  
      _xactSocket = socket;
      //_xactSocket.transform(UTF8.decoder).listen(processClientMessage, onError:errorManager, onDone:doneManager);
      _xactSocket.listen(processClientMessage, onError:errorManager, onDone:doneManager);
  
      _logStream.add('socketWorker: Transaction Socket Open: ${_xactSocket.remoteAddress} + ident: ${_guid.toString()}');
  
      _cmdStream.add({'addClient': this});
      _cmdStream.add({'addQueue' : this.queue});
    }
    catch(err)
    {
    }      
  }


  int get guid
  {
    return _guid;
  }

  sessionStatus get session
  {
    return _session;
  }

  void set session(sessionStatus updated)
  {
    _session = updated;
  }


  void errorManager(message)
  {
    try 
    {      
      _logStream.add('socketWorker: Transaction Socket Error: : ${_xactSocket.remoteAddress} + ident: ${_guid.toString()}');
  
      _xactSocket.close();
  
      _cmdStream.add({'removeQueue' : this.queue});
      _cmdStream.add({'removeClient': this});
    }
    catch(err)
    {
    }
  }


  void doneManager()
  {
    try 
    {   
      // Note there was a reported error that involved this call on what was likely a dead socket.  Resulting in an uncaught error
      // on the remoteAddress call.
      // ## TODO try and ensure that resources are properly disposed of in this case.
      
      //## Mod Oct 07 2014 - Note: can't have this here - _xactSocket may not be entirely valid at this point
      //_logStream.add('socketWorker: Transaction Socket Closed: : ${_xactSocket.remoteAddress} + ident: ${_guid.toString()}');
  
      _xactSocket.close();
  
      _cmdStream.add({'removeQueue' : this.queue});
      _cmdStream.add({'removeClient': this});
    }
    catch(err)
    {
    }
  }


  /**
   *   Note that messages are split on a 1024 byte packet size - so we need to aggregate complete
   *   messages based upon finding the null terminator
   */
  void processClientMessage(message)
  {
    try
    {
      // note message is a Uint8List
  
      //print('WorkPacket PRE: $message');
  
      //@@ TODO need to wrap this in try catch
      
      _aggBuffer += UTF8.decode(message);
  
      if(message[message.length-1] == 0)
      {
        //print('WorkPacket POST: $_aggBuffer');
  
        workPacket work = new workPacket(_aggBuffer);
  
        // reset the aggregation buffer for the next packet
  
        _aggBuffer = "";
  
        // Work units are dispensed differently depending upon the queueing method
  
        if(isolatePoolMonitor.type == isolatePoolMonitor.TYPE_ROUNDROBIN)
        {
          // special processing so that the protocol is determined before proceeding with further
          // operations
  
          switch(_session.protocolID)
          {
            case protocolValid.PROTOCOL_UNKNOWN:
  
                  // Until the protocol is determined we don't allow other packets to proceed.
                  // Once the protocol is defined it will manage the concurrency
  
                  // On the first pass ProtocolPending is false we don't allow more than one packet
                  // to proceed until the protocol has been identified.
  
                  // Protocol pending also has the effect that if an unrecognised packet comes through
                  // no more processing is possible.
  
                  if(!_session._protocolPending)
                  {
                    _session._protocolPending = true;
                  }
                  else
                  {
                    print("pausing queue");
                    queue.pause();
                  }
                  queue.add(work);
  
                  _dataStream.add("wakeup");
                  break;
  
            case protocolValid.PROTOCOL_MONITOR_A:
  
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
    }
    catch(err)
    {
    }      
  }

  void reply()
  {
    try 
    {
      if(GDSocketWorker) print('socketWorker: ${session.reply}');
  
      _xactSocket.write(session.reply);
    }
    catch(err)
    {
    }
  }
}






