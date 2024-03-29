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

library tedServer;

import 'dart:collection';
import 'dart:async';
import 'dart:isolate';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mailer/mailer.dart';
import 'package:crypto/crypto.dart';

part "io/serverMonitorIsolate.dart";
part "io/socketServer.dart";
part "io/socketWorker.dart";
part "io/socketDescription.dart";

part "io/workerIsolate.dart";
part "io/workPacket.dart";
part "io/workQueue.dart";

part "io/isolatePoolMonitor.dart";
part "io/isolateState.dart";

part "io/sessionStatus.dart";
part "io/protocolAdmin.dart";
part "io/protocolGuest.dart";
part "io/protocolAuth.dart";
part "io/protocolFlexLdr.dart";
part "io/protocolStudyLdr.dart";
part "io/protocolStudyLgr.dart";
part "io/protocolValid.dart";

part "io/crypto_util.dart";

part "db/sharedDB.dart";

part "globals.dart";


//-------------------------------------------------------------------------
/**
 *
 * Note: All top level variables are retained as a snapshot by DART and
 *       passed to each isolate predefined as they have been initialized here.
 *
 *
*/
//-------------------------------------------------------------------------

ReceivePort keepAlivePort;

Isolate     socketMonitorIsolate;
SendPort    socketMonitorReplyPort;

int         activeIsolates = 0;

socketDescription SSCR1 = new socketDescription("create", InternetAddress.LOOPBACK_IP_V4, 8888);
socketDescription SSCR2 = new socketDescription("create", InternetAddress.LOOPBACK_IP_V4, 12003);
socketDescription SSCR3 = new socketDescription("create", InternetAddress.LOOPBACK_IP_V4, 12002);

socketDescription PUBLIC1 = new socketDescription("create", InternetAddress.ANY_IP_V4, 12002);

socketDescription PUBLIC_80    = new socketDescription("create", InternetAddress.ANY_IP_V4, 80);
socketDescription PUBLIC_12003 = new socketDescription("create", InternetAddress.ANY_IP_V4, 12003);
socketDescription PUBLIC_12002 = new socketDescription("create", InternetAddress.ANY_IP_V4, 12002);


//-------------------------------------------------------------------------
/**
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
 */
//-------------------------------------------------------------------------

void main(List<String> args) {
  
  print('Copyright 2013-2014 - Carnegie Mellon University All Rights Reserved.');

  // Keep the main isolate alive until we are finished.

  keepAlivePort = new ReceivePort();
  keepAlivePort.listen(rootListener);

  // Override any defaults
  
  processCommandLine(args);
    
  try
  {
     Isolate.spawn(serverMonitorIsolateEntry,
                   keepAlivePort.sendPort).then((newisolate) => socketMonitorIsolate = newisolate,
                                                     onError: (err) => exit(1));
  }
  catch(err)
  {
    keepAlivePort.close();

    print('server startup failed: $err');
  }

  // Watch for close attempts

  inputStream = stdin
    .transform(new AsciiDecoder());

  streamSubscription =
    inputStream.listen(cmdLineProcessor,
      onDone: () { print('file is now closed'); },
      onError: (e) { print(e.toString()); });
}


void processCommandLine(List<String> cmdArgs) {

  NetworkInterface.list(type: InternetAddressType.ANY).then(printInterfaces);
  
}


void printInterfaces(List<NetworkInterface> netConfig) {

  //List<NetworkInterface> hostPort = netConfig;
    
  print("Number of Interfaces: ${netConfig.length}");
  
  for(var interface in netConfig)
  {
    print(interface.name);  
    print(interface.addresses);
  }
}


//-------------------------------------------------------------------------
/**
 *
 *  This is the root isolate listener.
 *
 *  It's purpose is to wait for the monitor isolate to signal that all worker isolates
 *  have shut down prior to releasing the keepAlivePort which allows the root isolate
 *  to exit and thus terminate the program gracefully.
 * 
 *   TODO: Since the way the port messaging was changed this no longer shuts down as 
 *         designed. 
 *
 */
//-------------------------------------------------------------------------

void rootListener(msg)
{


  if(msg is SendPort)
  {
    socketMonitorReplyPort = msg;
  }

  else if(msg is String)
  {
    switch(msg)
    {
      case 'start':
            print("Monitor Isolate : Starting");

            activeIsolates++;

            // Send the initial socketServer creation request

            //socketMonitorReplyPort.send(PUBLIC1);
            //socketMonitorReplyPort.send(PUBLIC_80);
            socketMonitorReplyPort.send(PUBLIC_12003);

            break;

      case 'shutdown':
            if(activeIsolates > 0)
                  activeIsolates--;

            if(activeIsolates == 0)
            {
              keepAlivePort.close();

              print('server has shut down');
            }
            print("Isolate ${activeIsolates+1} : shutdown");

            break;

      default:
            print(msg);
            break;
    }
  }
}


//-------------------------------------------------------------------------
/**
 *
 * Command line processor
 *
 */
//-------------------------------------------------------------------------

var    inputStream;
var    streamSubscription;
String FSMstate = 'start';

cmdLineProcessor(line)
{

  line = line.trim();

  switch(FSMstate)
  {
    case 'start':

      print('Server Started : $line?\n');

      FSMstate = 'cmdWatch';
      break;

    case 'cmdWatch':

      switch(line.toLowerCase())
      {
        case "exit":
        case "quit":
        case "stop":
          print('Are you sure you want to exit: Y / N\n');
          FSMstate = 'confirmClose';
          break;

        default:
          print('Unknown Command : $line?\n');
          break;
      }
      break;

    case 'confirmClose':

      switch(line.toLowerCase())
      {
        case "y":
          print('Shutting Down:\n');
          FSMstate = 'closed';
          keepAlivePort.close();
          streamSubscription.cancel();
          break;

        default:
          print('Okay: Shutdown Cancelled\n');
          FSMstate = 'cmdWatch';
          break;
      }
      break;

    default:
      break;
  }
}


