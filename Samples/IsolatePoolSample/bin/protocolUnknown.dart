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


/**
 * This constitutes the base class for all protocol status types
 *
 * This object is passed back and forth between the monitorIsolate and the workerIsolates
 * to maintain the state of the protocols being used.
 *
 */
class protocolUnknown
{
  static const String PROTOCOL_UNKNOWN        = "UNKNOWN";
  static const String PROTOCOL_AUTH_A         = "AUTHENTICATE.1.0";
  static const String PROTOCOL_MONITOR_A      = "MONITOR.1.0";
  static const String PROTOCOL_ADMIN_A        = "ADMIN.1.0";
  static const String PROTOCOL_GUEST_A        = "GUEST.1.0";
  static const String PROTOCOL_FLEXLOADER_A   = "FLEX_LOADER.1.0";
  static const String PROTOCOL_STUDYLOADER_A  = "STUDY_LOADER.1.0";
  static const String PROTOCOL_STUDYLOGGER_A  = "STUDY_LOGGER.1.0";

  int            _socketWorkerGUID;
  SendPort       _isolateKey;

  bool           hasReply = false;
  String         reply;

  String         policyRequest = "<policy-file-request/>\x00";    // Note the null terminator

  // Constructor

  protocolUnknown(this._socketWorkerGUID);



  void packetProcessor(var workData)
  {
    // If this is a Flash policy request - handle it first

    print("packetProcessor: $workData");

    // This packet type will occur when the server is used as a Flash XML Socket Server
    // This will not occur in a WebSocket environment. (the crossdomain.xml file is used instead)

    if(workData == policyRequest)
    {
      print("Policy Request Received");

      hasReply = true;
      reply =
              '<?xml version="1.0"?>\n'
              '<!-- DART: TEDServer Cross Domain Access -->\n'
              '<cross-domain-policy>\n'
              '  <site-control permitted-cross-domain-policies="all"/>\n'
              '  <allow-access-from domain="*" to-ports="12000-12004"/>\n'
              '</cross-domain-policy>\n\x00';
    }
    else
    {
      try
      {
        var authObj = JSON.decode(workData);

        switch(authObj.type)
        {
          case 'DB_A':


            break;

          default:
            print("unrecognised Authentication Protocol: $workData");

            hasReply = true;
            reply    = 'Authentication Request Denied\n\x00';

            break;
        }
      }
      catch(err)
      {
        print("unrecognised Authentication Protocol: $workData");

        hasReply = true;
        reply    = 'Authentication Request Denied\n\x00';
      }
    }

  }


  /**
   *  The protocol type is used to determine the type of processing done on the
   *  packet within the workerIsolate.
   *
   */
  void set id(String type)
  {
    _protocolType = type;
  }

  String get id
  {
    return _protocolType;
  }


  /**
   * This uniquely identifies the socketWorker object within the isolatePool client Map
   * so that we can update its protocolUnknown member after it has been updated
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
   *  This allows us to identify the isolate within the isolatePool in which
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







