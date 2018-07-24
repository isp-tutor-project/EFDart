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

library IsolateBench;

import "dart:async";
import "dart:isolate";
import "dart:io";

part "WorkerIsolate.dart";

int       doneCount = 0;
Stopwatch watch;
SendPort  rootPort;

void main()
{
  watch = new Stopwatch();
  watch.start();

  port.receive(onDone);

  isolatePool();
  //individualIsolates();
}


void individualIsolates()
{
  for(var i1=0 ; i1 < 50 ; i1++)
  {
    SendPort newIsolate = spawnFunction(workerEntry);

    newIsolate.send(i1+1, port.toSendPort());
  }
}


void isolatePool()
{
  const cnt = 8;

  List newIsolate = new List();
  int  curIsolate = 0;

  for(var i1=0 ; i1 < cnt ; i1++)
  {
    newIsolate.add(spawnFunction(workerEntry));
  }

  for(var i1=0 ; i1 < 50 ; i1++)
  {
    newIsolate[curIsolate].send("message${i1} on thread $curIsolate", port.toSendPort());

    curIsolate = (curIsolate+1) % cnt;
  }

}


onDone(msg, replyPort)
{
//  print(msg);

  doneCount++;

  if(doneCount >= 50)
  {
    print(watch.elapsedMilliseconds.toString());

    port.close();
  }
}




