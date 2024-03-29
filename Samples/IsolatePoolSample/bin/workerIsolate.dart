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

/** --------------------------------------------------------------------
*
*   isolate Entry/Exit point
*
------------------------------------------------------------------------- */

workerIsolate _workerIsolate;

SendPort workerEntry()
{
  print("workerIsolate: worker isolate Entry");

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  _workerIsolate = new workerIsolate();

  port.receive(_workerIsolate.workProcessor);
}



/** -------------------------------------------------------------------------
 *
 *  The workerIsolate class maintains the worker isolates and farms out
 *  packets as they arrive.
 *
 *  Note: Even though this is implemented as a singleton - the singleton
 *        property is not global but is isolate specific. i.e. each isolate
 *        may have its own singleton instance.
 *
 ------------------------------------------------------------------------- */

class workerIsolate
{

  SendPort    rport;
  workPacket  workUnit;
  Timer       delay;

  workerIsolate()
  {
  }

  /** --------------------------------------------------------------------
  *
  *   Isolate Port - callback function
  *
  ------------------------------------------------------------------------*/

  void workProcessor(workPacket work, SendPort replyTo)
  {
    rport = replyTo;

    workUnit = work;

    if(workUnit.id == protocolUnknown.PROTOCOL_UNKNOWN)
    {
      workUnit.protocol.packetProcessor(workUnit.workData);

      print("processing protocol: ${work.protocol.id}");
      
    }

    rport.send(workUnit.protocol);

    //  delay = new Timer(new Duration(milliseconds: 200), handleTimeout);
  }

  /**
   * Used as an artificial work unit for test
   */
  void handleTimeout()
  {
    rport.send(workUnit.protocol);
  }
}












