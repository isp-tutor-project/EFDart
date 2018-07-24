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

/** --------------------------------------------------------------------
*
*   isolate Entry/Exit point
*
------------------------------------------------------------------------- */

workerIsolate _workerIsolate;

SendPort    IsolatePoolMonitorPort;
ReceivePort workerIsolatePort;

void workerIsolateEntry(SendPort reply)
{
  if(GDWorkerIsolate) print("workerIsolate: worker isolate Entry");

  workerIsolatePort      = new ReceivePort();
  IsolatePoolMonitorPort = reply;

  IsolatePoolMonitorPort.send(workerIsolatePort.sendPort);

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  _workerIsolate = new workerIsolate();

  workerIsolatePort.listen(_workerIsolate.workProcessor);
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

  workerIsolate()
  {
  }

  /** --------------------------------------------------------------------
  *
  *   Listening port of the Isolate
  *   Workpackets are allocated to isolates and sent here by the isolate pool monitor.
  *
  ------------------------------------------------------------------------*/

  void workProcessor(packet)
  {
    _GSharedDB = new sharedDB();            // genereate an isolate specific DB connection

    _GIsolatePoolPort = packet.replyTo;

    // Note that we are dependent upon the protocol releasing the isolate
    // by sending an approriate reply to the isolatepoolmonitor

    switch(packet.protocolID)
    {
      case protocolValid.PROTOCOL_UNKNOWN:

        new protocolAuth(packet);

        if(GDWorkerIsolate) print("processing protocol: ${packet.session.protocolID}");
        break;

      case protocolValid.PROTOCOL_ADMIN_A:

        new protocolAdmin(packet);

        if(GDWorkerIsolate) print("processing protocol: ${packet.session.protocolID}");
        break;

      case protocolValid.PROTOCOL_STUDYLOADER_A:

        new protocolStudyLdr(packet);

        if(GDWorkerIsolate) print("processing protocol: ${packet.session.protocolID}");
        break;

      case protocolValid.PROTOCOL_FLEXLOADER_A:

        new protocolFlexLdr(packet);

        if(GDWorkerIsolate) print("processing protocol: ${packet.session.protocolID}");
        break;

      case protocolValid.PROTOCOL_STUDYLOGGER_A:

        new protocolStudyLgr(packet);

        if(GDWorkerIsolate) print("processing protocol: ${packet.session.protocolID}");
        break;

      default:

        _GIsolatePoolPort.send(packet.protocol);
        break;
    };

  }

}












