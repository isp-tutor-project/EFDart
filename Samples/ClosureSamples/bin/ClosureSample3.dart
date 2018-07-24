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


library ClosureSample3;

import 'dart:io';
import 'dart:isolate';
import 'dart:async';

part "com/closureObj.dart";
part "com/timerIsolate.dart";


void main()
{

  port.receive(rootIsolateExit);

  SendPort func1 = spawnFunction(timerIsolateEntry);

  func1.send(3, port.toSendPort());
}


void rootIsolateExit(msg, replyTo)
{
  print("Root Isolate Exit");

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  port.close();
}


