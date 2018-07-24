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

library isolateSample;

import 'dart:isolate';
import 'dart:io';

part "isolateChild.dart";


/** -------------------------------------------------------------------------
 * 
 * Note: All top level variables are retained as a snapshot and passed to each 
 *       isolate predefined as they were initialized.
 *        
 ------------------------------------------------------------------------- */

String      globalDataObj="myGlobal";

SendPort    childIsolatePortA;
SendPort    childIsolatePortB;
ReceivePort keepAlivePort;

int         activeIsolates = 0;



/** -------------------------------------------------------------------------
 * 
 * You can use either the default receive port of the root isolate or
 * create a new ReceivePort to keep the root isolate alive
 * 
 ------------------------------------------------------------------------- */

void main() 
{  
// Note: this sequence is valid code. But represents an invalid use of the 
//       childIsolate function - isolate entry functions must be treated with care
  
//  childIsolate();
//  
//  port.toSendPort().send("root termination");
//  
//  return;
  
  print("Root Isolate sees: $globalDataObj");
  
  globalDataObj = "GDB";
  
  print("Updated Root Isolate sees: $globalDataObj");
  
  childIsolatePortA = spawnFunction(childIsolateEntry);
  childIsolatePortB = spawnFunction(childIsolateEntry);
  
  // Note that it is sufficient to create a new ReceivePort in the root isolate 
  // without init'g it's callback to keep the isolate alive
  // However it is necessary to init the callback to properly use the keepalive port
  // See bottom of "main" for more
  
  keepAlivePort = new ReceivePort();
  keepAlivePort.receive(rootListener);

  childIsolatePortA.send('startup', keepAlivePort.toSendPort());
  childIsolatePortB.send('startup', keepAlivePort.toSendPort());
  
  // Note that it is sufficient to add a callback listener to the default ReceivePort
  // in order to keep the root isolate alive
  
// port.receive(rootListener);
  
  // Then perform async work packages
 
  childIsolatePortA.send('non-terminating work package A', keepAlivePort.toSendPort());
  childIsolatePortA.send('non-terminating work package B', keepAlivePort.toSendPort());
  childIsolatePortA.send('non-terminating work package C', keepAlivePort.toSendPort());
  childIsolatePortA.send('non-terminating work package D', keepAlivePort.toSendPort());

  childIsolatePortB.send('non-terminating work package2 A', keepAlivePort.toSendPort());
  childIsolatePortB.send('non-terminating work package2 B', keepAlivePort.toSendPort());
  childIsolatePortB.send('non-terminating work package2 C', keepAlivePort.toSendPort());
  childIsolatePortB.send('non-terminating work package2 D', keepAlivePort.toSendPort());
  
  childIsolatePortA.send('shutdown', keepAlivePort.toSendPort());
  childIsolatePortB.send('shutdown', keepAlivePort.toSendPort());
//  childIsolatePort.send('stop message', port.toSendPort());
  
  print("all packages queued");
  
  // If you were to use this to close the root isolate it would terminate the worker
  // child isolates possibly before they completed their work packages.
  
  //keepAlivePort.close();
}


/** -------------------------------------------------------------------------
 * 
 *  This is the root isolate listener.
 *  
 *  It's purpose is to wait for all the worker isolates to shut down prior
 *  to releasing the keepAlivePort which allows the root isolate to exit
 * 
 ------------------------------------------------------------------------- */

void rootListener(msg, replyTo) 
{

  print("Root listener sees: $globalDataObj");
  
  print("processing $msg");
  
  if(msg is String) 
  {
    switch(msg)
    {
      case 'startup':
            activeIsolates++;
        break;
        
      case 'shutdown':
            activeIsolates--;
          break;      
    }
    
    if(activeIsolates == 0)
    {      
        keepAlivePort.close();
        
        print('server has shut down');
    }
    //port.close();
  }
}



