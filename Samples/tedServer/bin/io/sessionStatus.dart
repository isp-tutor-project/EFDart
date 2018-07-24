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

// Global shared DB object instance - This persists within the isolate.

sharedDB DB;


/**
 * This constitutes the base class for all protocol status types
 *
 * This object is passed back and forth between the monitorIsolate and the workerIsolates
 * to maintain the state of the protocols being used.
 *
 */
class sessionStatus
{
  bool           _protocolPending = false;  // Unless user authenticates this flag keeps them from proceeding

                                            // The authentication process involves sending an authorization packet with
                                            // user name password and a protocol request.  If authentication is successful
                                            // the line is switched to the requested protocol.

  String _protocolType = protocolValid.PROTOCOL_UNKNOWN;

  String         _User;
  String         _Password;
  String         _StudyGroup;
  String         _DataColl;
  String         _AccountColl;
  String         _Profile;
  String         _loader;

  Stopwatch      _taskTimer;

  int            _socketWorkerGUID;
  SendPort       _isolateKey;

  bool           releaseIsolate = false;    // This makes it possible to send data without releasing the isolate
  bool           hasReply       = false;
  String         reply;


  // Constructor

  sessionStatus(this._socketWorkerGUID);


  // All protocol processors call this directly to forward results back to the 'isolatePoolMonitor' isolate
  // and on to the clientSocket which lives in that isolate

  Send(String _reply, [bool _releaseIsolate = true])
  {
    releaseIsolate = _releaseIsolate;
    hasReply       = true;
    reply          = _reply;

    _GIsolatePoolPort.send(this);
  }


  /**
   *  The protocol type is used to determine the type of processing done on the
   *  packet within the workerIsolate.
   *
   */
  void set protocolID(String type)
  {
    _protocolType = type;
  }

  String get protocolID
  {
    return _protocolType;
  }


  void set profile(String value)
  {
    _Profile = value;
  }

  String get profile
  {
    return _Profile;
  }


  void set loader(String value)
  {
    _loader = value;
  }

  String get loader
  {
    return _loader;
  }



  void setStartTime()
  {
    _taskTimer = new Stopwatch();
    _taskTimer.start();
  }


  int getElapsedTime()
  {
    _taskTimer.stop();

    return _taskTimer.elapsedMilliseconds;
  }


  /**
   * This uniquely identifies the socketWorker object within the isolatePoolMonitor client Map
   * so that we can update its sessionStatus member after it has been updated
   * in the workerIsolate.
   *
   */
  void set guid(int GUID)
  {
    _socketWorkerGUID = GUID;
  }


  int get guid
  {
    return _socketWorkerGUID;
  }


  /**
   *  This allows us to identify the isolate within the isolatePoolMonitor in which
   *  we are running this protocol.  In this way we can free the workerIsolate when
   *  the protocol finishes working
   *
   */
  void set key(SendPort port)
  {
    _isolateKey = port;
  }


  SendPort get key
  {
    return _isolateKey;
  }

}







