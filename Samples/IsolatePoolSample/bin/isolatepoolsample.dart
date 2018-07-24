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

library isolatePoolSample;

import 'dart:collection';
import 'dart:async';
import 'dart:isolate';
import 'dart:io';
import 'dart:convert';
//import 'dart:math';

part "socketMonitor.dart";
part "socketServer.dart";
part "socketWorker.dart";
part "socketDescription.dart";

part "workerIsolate.dart";
part "workPacket.dart";
part "workQueue.dart";

part "isolatePool.dart";
part "isolateState.dart";

part "protocolUnknown.dart";


/** -------------------------------------------------------------------------
 *
 * Note: All top level variables are retained as a snapshot by DART and
 *       passed to each isolate predefined as they have been initialized here.
 *
 *
 ------------------------------------------------------------------------- */

ReceivePort keepAlivePort;
SendPort    socketMonitorPort;

int         activeIsolates = 0;

socketDescription SSCR1 = new socketDescription("create", InternetAddress.LOOPBACK_IP_V4, 8888);
socketDescription SSCR2 = new socketDescription("create", InternetAddress.LOOPBACK_IP_V4, 12003);


/** -------------------------------------------------------------------------
 *
 *  Program Entry Point:
 *
 *  1. Create a receive port to keep the root isolate alive until the
 *     socketMonitor runs out of  tasks.
 *
 *  2. Create the socketMonitor Isolate: this monitors the server sockets
 *
 *  3. Create a server socket as defined in the SSCR1 var description above.
 *
 ------------------------------------------------------------------------- */

void main()
{

  // Keep the main isolate alive until we are finished.

  keepAlivePort = new ReceivePort();
  keepAlivePort.receive(rootListener);

  try
  {
     socketMonitorPort = spawnFunction(socketMonitorEntry);

     // Send the initial socketServer creation request

     socketMonitorPort.send(SSCR2, keepAlivePort.toSendPort());
  }
  catch(e)
  {
    keepAlivePort.close();

    print('server startup failed');
  }

}


/** -------------------------------------------------------------------------
 *
 *  This is the root isolate listener.
 *
 *  It's purpose is to wait for the monitor isolate to signal that all worker isolates
 *  have shut down prior to releasing the keepAlivePort which allows the root isolate
 *  to exit and thus terminate the program gracefully.
 *
 ------------------------------------------------------------------------- */

void rootListener(msg, replyTo)
{

  print("Monitor says: $msg");



  if(msg is String)
  {
    switch(msg)
    {
      case 'startup':
            activeIsolates++;
            break;

      case 'shutdown':
            if(activeIsolates > 0)
                  activeIsolates--;

            if(activeIsolates == 0)
            {
              keepAlivePort.close();

              print('server has shut down');
            }

            break;
    }
  }
}



