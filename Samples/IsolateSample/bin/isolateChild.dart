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

part of isolateSample;


/** --------------------------------------------------------------------
* 
*  Note: if you call this directly it will modify the port of the current active 
*   isolate - e.g. if called from "main" it will add a listener to the root
*   isolate and not produce an error as you might assume.
* 
*   Magic: This function returns the default ReceivePort of the new Isolate 
*          which is automatically created with it by the spawnFunction call.
*          This function should be treated as an initializer for the isolate.
*          spend as little time here as possible
*          
------------------------------------------------------------------------- */

SendPort childIsolateEntry() 
{
  print("isolate has been spawned");

  print("isolate sees $globalDataObj");
  
  // Note: As of SDK 0.5.20.4_r24275 the spawnFunction overrides any return value
  //       and substitues the default ReceivePort for the isolate - So this won't work.
  
//  ReceivePort keepAlivePort = new ReceivePort();
//  keepAlivePort.receive(isolateListener);
//  
//  return keepAlivePort.toSendPort();
  
  
  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately
  
  port.receive(isolateListener);
  
  // Note: the isolate doesn't do anything (run) until this function returns.
  //while(true);
}


/** --------------------------------------------------------------------
 * 
*   Isolate callback function
*   
*   Think of this function as living inside the isolate and parsing 
*   messages sent to the isolate from outside. 
*      
------------------------------------------------------------------------*/

void isolateListener(msg, replyTo)  
{
  print('parsing work package');
  print("isolate listener sees $globalDataObj");
  
  globalDataObj = globalDataObj + "1";
  
  if(msg is String)
  {
    print(msg);
  }
  
  // Used in example of how the root isolate default ReceivePort can be used as 
  // a keepAlive for the root Isolate
  
//  if(msg == "root termination")
//                    port.close();
  
  if (replyTo != null) 
          replyTo.send(msg);
  
  //while(true);
}






