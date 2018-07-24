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


part of ClosureSample3;


closureObj  testObj;
Completer   completer;
SendPort    replyAddress;

/** --------------------------------------------------------------------
*
*   isolate Entry/Exit point
*
------------------------------------------------------------------------- */

SendPort timerIsolateEntry()
{
  print("timerIsolate Entry");

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  port.receive(timerIsolateProcessor);
}


void timerIsolateExit(msg, replyTo)
{
  print("timerIsolate Exit");

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  port.close();
}


/** --------------------------------------------------------------------
*
*   Isolate Port - callback function
*
------------------------------------------------------------------------*/

void timerIsolateProcessor(msg, replyTo)
{
  print('parsing timerIsolate work package');

  // Keep isolate copy of reply address
  replyAddress = replyTo;
  
  var reply = "Processed Data: " + msg.toString();

  print(reply);

  completer = new Completer();

  completer.future.then(onSuccess).catchError(onError);  
  
  Timer timer = new Timer(const Duration(milliseconds: 1000), timeOut);

  if(msg != "3")
  {
      if (reply != null && replyTo != null)
                         replyTo.send(reply);
  }
}


void onSuccess(msg)
{
  replyAddress.send("Success from inside Timer Isolate");
}


void onError(msg)
{
  replyAddress.send("Error from inside Timer Isolate");
}


void timeOut()
{
  // later when value is available, call:
  completer.complete("sccuess");

  // alternatively, if the service cannot produce the value, it
  // can provide an error:
  // completer.completeError(error);
}



