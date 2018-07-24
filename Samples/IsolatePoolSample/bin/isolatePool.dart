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


/** -------------------------------------------------------------------------
 *
 *  The isolatePool class maintains the worker isolates and farms out
 *  packets as they arrive.
 *
 *  Note: Even though this is implemented as a singleton - the singleton
 *        property is not global but is isolate specific. i.e. each isolate
 *        may have its own singleton instance. So we don't ever want to call
 *        this anywhere except in the root isolate.
 *
 ------------------------------------------------------------------------- */

class isolatePool
{
  Map<SendPort,String>    _isolates       = new Map<SendPort,String>();
  ListQueue               _workQueue      = new ListQueue();

  Map<int, socketWorker>  _clients        = new Map<int,socketWorker>();    // A map of active sockets
  int                     _clientNdx      = 0;                              // current queue being processed

  ReceivePort             _port           = new ReceivePort();
  StreamSink              _logStream;

  int                     _guid           = 0;

  static String           type            = TYPE_ROUNDROBIN;            // default to RR

  static const String     TYPE_ROUNDROBIN = "RoundRobin";               // There are currently 2 types - RR and FIFO
  static const String     TYPE_FIFO       = "FIFO";                     // There are currently 2 types - RR and FIFO


  isolatePool.create(int isolateCnt, StreamController dataEvent, StreamSink logStream, [String _type = null] )
  {
    // Set the isolate pool type

    type = _type;

    // Listen for data events

    dataEvent.stream.listen(makeWork);

    _logStream  = logStream;


    // When work is done assign new work units using algorithm specific methods

    if(type == TYPE_ROUNDROBIN)
      _port.receive(rrWorkDone);
    else
      _port.receive(fifoWorkDone);


    // Create a pool of threads

    try
    {
      // Make enough worker threads to keep the processor busy.
      // no need to make more than cores and hyperthreading can accomodate on your CPU

      for(var i1 = 0 ; i1 < isolateCnt ; i1++)
        _isolates[spawnFunction(workerEntry)] = "free";

    }
    catch(e)
    {
      print(e);

      throw(e);
    }
  }


  /**
   * This acts as a wakeup call to the Pool to indicate new work is available.
   * However it may be that all isolates are currently busy.  In which case
   * we go to sleep until a work isolate completes and it's WorkDone function
   * kick starts the polling process again.
   *
   */
  makeWork(var data)
  {
    if(type == TYPE_ROUNDROBIN)
    {
      _rrDispatchWork();

//      print("work unit: " + data);
    }
    else
    {
      _workQueue.add(data);

      fifoDispatchWork();
    }
  }


  //-----------------------------------------------------------------------------


  fifoDispatchWork()
  {
    int noneFree;

    while(_workQueue.isNotEmpty)
    {
      noneFree = _isolates.length;

      _isolates.forEach((SendPort k, String v)
      {
        noneFree--;

        if(v == "free")
        {
          v="busy";

          workPacket packet = _workQueue.removeFirst();

          packet.key = k;

          k.send(packet, _port.toSendPort());
        }
      });

      // Either we will have dispatched a work unit to a waiting workerIsolate
      // or none were free so we quit checking and wait for an isolate to finish
      // fifoWorkDone will cause us to rescan the queues

      if(noneFree == 0)
                  break;
    }
  }


  fifoWorkDone(msg, port)
  {
    _isolates[port] = "free";

    fifoDispatchWork();
  }


  //-----------------------------------------------------------------------------


  addClient(socketWorker client)
  {
    _clients[client.guid] = client;

    _rrDispatchWork();
  }


  removeClient(socketWorker client)
  {
    _clients.remove(client.guid);
  }


  /**
   *  Note: we make an implicit assumption that the client map keys are returned in the same order each time
   *
   */
  _rrDispatchWork()
  {
    int           testCount = 1;
    int           noneFree;
    workQueue     socketQueue;
    socketWorker  worker;

    Iterable  ikeys = _isolates.keys;   // make an iterable list of isolateWorker maps
    Iterable  ckeys = _clients.keys;    // make an iterable list of socketWorker maps

    // Ensure the socket index does not exceed the queue count
    // This can occur when sessions are closed and the queue contracts

    if(_clients.isNotEmpty)
      _clientNdx = _clientNdx % ckeys.length;

    // If there is an existing queue
    // In RR there is on workQueue per client session

    while(_clients.isNotEmpty)
    {
      // Poll the queues to find one with data

      worker      = _clients[ckeys.elementAt(_clientNdx)];
      socketQueue = worker.queue;

      // If this queue has data try and find a isolate to run it on

      if(socketQueue.isNotEmpty && socketQueue.isRunning)
      {
        // If we can exhaust this count then there are no free isolates

        noneFree = _isolates.length;

        // Scan the isolate map to find a free one

        for(SendPort k in ikeys)
        {
          noneFree--;

          if(_isolates[k] == "free")
          {
            _isolates[k]="busy";

            _logStream.add("running on Isolate" + (noneFree+1).toString());

            workPacket packet = socketQueue.removeFirst();

            // Pass this isolates Map key with the packet so we can free the
            // isolate on the other side of the asynchronous process

            packet.protocol = worker.protocol;
            packet.key = k;

            //print("passing:" + packet.protocol.id.toString());

            k.send(packet, _port.toSendPort());

            // Round Robin - Cycle through the socket queues in order
            // Note: don't increment if unsuccessful obtaining an isolate

            _clientNdx++;
            _clientNdx = _clientNdx % _clients.length;

            // move on to the next round - note if socketQueue is
            // exhausted this would error on the next pass anyway

            break;
          }
        }
        // Either we will have dispatched a work unit to a waiting workerIsolate
        // or none were free so we quit checking and wait for an isolate to finish.
        // rrWorkDone will cause us to re-poll the queues

        if(noneFree == 0)
        {
          _logStream.add("*** ISOLATES EXHAUSTED ***");
          break;
        }
      }

      // Cycle through the socket queues to find one with data

      else
      {
        // If we have checked them all, quit

        if(testCount >= _clients.length)
        {
          break;
        }

        testCount++;
        _clientNdx++;
        _clientNdx = _clientNdx % _clients.length;
      }
    }
  }


  rrWorkDone(protocol, port)
  {
    socketWorker  client;
    
    if(_clients.containsKey(protocol.guid))
    {      
      client = _clients[protocol.guid];

      client.protocol = protocol;
      client.queue.resume();

      if(protocol.hasReply)
               client.reply();
    }

    if(_isolates.containsKey(protocol.key))
    {
      _isolates[protocol.key] = "free";
    }

    _rrDispatchWork();
  }

}


