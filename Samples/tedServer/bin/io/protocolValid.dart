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


/**
 * This constitutes the base class for all protocol status types
 *
 * This object is passed back and forth between the monitorIsolate and the workerIsolates
 * to maintain the state of the protocols being used.
 *
 */
abstract class protocolValid
{
  static const String PROTOCOL_UNKNOWN        = "UNKNOWN";
  static const String PROTOCOL_AUTH_A         = "AUTHENTICATE.1.0";
  static const String PROTOCOL_MONITOR_A      = "MONITOR.1.0";
  static const String PROTOCOL_ADMIN_A        = "ADMIN.1.0";
  static const String PROTOCOL_GUEST_A        = "GUEST.1.0";
  static const String PROTOCOL_FLEXLOADER_A   = "FLEX_LOADER.1.0";
  static const String PROTOCOL_STUDYLOADER_A  = "STUDY_LOADER.1.0";
  static const String PROTOCOL_STUDYLOGGER_A  = "STUDY_LOGGER.1.0";


  static String validate(String reqProtocol)
  {
    String resultProtocol = PROTOCOL_UNKNOWN;

    try
    {
      switch(reqProtocol)
      {
        case PROTOCOL_UNKNOWN:
        case PROTOCOL_AUTH_A:
        case PROTOCOL_MONITOR_A:
        case PROTOCOL_ADMIN_A:
        case PROTOCOL_GUEST_A:
        case PROTOCOL_FLEXLOADER_A:
        case PROTOCOL_STUDYLOADER_A:
        case PROTOCOL_STUDYLOGGER_A:

          resultProtocol = reqProtocol;
          break;

        default:
          resultProtocol = PROTOCOL_UNKNOWN;
          break;
      }
    }
    catch(err)
    {
      print("received invalid protocol type");
    }

    return resultProtocol;
  }

}







