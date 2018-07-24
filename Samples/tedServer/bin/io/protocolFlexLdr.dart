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


class protocolFlexLdr
{
  sessionStatus session;

  String _Prequest;

  Map profile;

  var    _reply;

  // These must match the _progressSet:ArrayCollection in CClassListTabNav

  final String _READY      = "READY";
  final String _INPROGRESS = "IN PROGRESS";
  final String _COMPLETE   = "COMPLETE";

  String progress;


  /**
   * Process authentication packets
   */
  protocolFlexLdr(workPacket workUnit)
  {
    // Reset the response flags

    session = workUnit.session;

    if(GDProtocol) print("Passed Protocol: $session");

    session.releaseIsolate = false;
    session.hasReply       = false;

    // If this is a Flash policy request - handle it first

    if(GDProtocol) print("packetProcessor: ${workUnit.workData}");

    try
    {
      workUnit.workData = workUnit.workData.substring(0,workUnit.workData.length - 1);

      if(GDProtocol) print(workUnit.workData);

      var dataObj = JSON.decode(workUnit.workData, reviver:reviverFunc);

      if(GDProtocol) print(dataObj.runtimeType);
      if(GDProtocol) print("Packet:" + "Flex Loader Request: $dataObj");

      switch(dataObj["request_type"])
      {
        // This builds a loader image based upon the users Flex profile

        case 'REQUEST_FLEX_LOADER':

          // Switch to the requested protocol - all future traffic on this socket will be managed by this
          // protocol unless/until another PROTOCOL_SWITCH is requested.

          if(dataObj["protocol_request"] != null)
          {
            session.protocolID = protocolValid.validate(dataObj["protocol_request"].toUpperCase());

            if(GDProtocol) print("Protocol Switch: ${session.protocolID}");
          }

          _GSharedDB.access("TED").then(buildLoader, onError: onAccessError);

          break;

        default:
          if(GDProtocol) print("Unrecognised Flex Loader Protocol Packet: ${workUnit.workData}");

          session.Send('{"result":"fail", "Description":"Flex Loader Request Denied"}\x00');
          break;
      }
    }
    catch(err)
    {
      if(GDProtocol) print("Error in Protocol: $err");

      session.Send('{"result":"fail", "Description":"Flex Loader Request Denied"}\x00');
    }
  }


  /**
   *  Revive _id objects
   */
  reviverFunc(key, value)
  {
    if(key == "_id")
    {
      try
      {
        if(value.length == 24)
         return ObjectId.parse(value);
      }
      catch(err)
      {
        return value;
      }
    }
    return value;
  }



  //*********************************************************************************************
  //*********************************************************************************************

  /**
   *  Here we decompose the users progress through a Flex and return the appropriate loader for
   *  the phase of the Flex they are in.
   *
   */
  buildLoader(result)
  {
    // This protocol is designed to return a fully qualified loader environment for a research Flex
    // Build a response packet - basic packet is the account object

    _reply = new Map();

    _reply["type"]   = "Flexloader";
    _reply["result"] = "success";

    _GSharedDB.collection("loaders").findOne(where.eq("_id", session.loader)).then(onLoader, onError: onAccessError );

  }


  //
  onLoader(result)
  {
    if(GDProtocol) print(result.runtimeType);
    if(GDProtocol) print("Loader:" + "record: $result");

    try
    {
      // now add the loader to the response packet

      _reply["_loader"] = result;

      // If the loader is a flex domain loader, it only has an interface link

      if(result["domain"] == "flex")
      {
        _GSharedDB.collection("interfaces").findOne(where.eq("_id",_reply["_loader"]["_xface"])).then(onInterface, onError: onAccessError );
      }

    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid");

      session.Send('{"result":"fail", "Description":"Loader encoding invalid"}\x00');
    }
  }

  //
  onInterface(result)
  {
    if(GDProtocol) print(result.runtimeType);
    if(GDProtocol) print("Interface: record: $result");

    try
    {
      // now add the loader to the response packet

      _reply["_loader"]["_xface"] = result;

      // If the loader is flash domain it has all 4 - _library _module _speller _xface
      // They need to be queried and added to the response packet

      session.Send(JSON.encode(_reply, toEncodable:marshallObject) + '\x00');
    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid: + $err");

      session.Send('{"result":"fail", "Description":"interface encoding invalid"}\x00');
    }
  }


  //
  onAccessError(err)
  {
    if(GDProtocol) print("Error on Authentication attempt:");

    session.Send('{"result":"fail", "Description":"db error"}\x00');
  }


  /**
   * Manage _id values as 24 character hex strings
   * Decode Reviver manages them on the way back
   */
  marshallObject(objValue)
  {
    if(objValue is ObjectId)
    {
      return objValue.toHexString();
    }

    return objValue;
  }


  //*********************************************************************************************
  //*********************************************************************************************

}











