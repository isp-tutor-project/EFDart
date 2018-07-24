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


class protocolStudyLgr
{
  sessionStatus _session;

  Map    _packet;
  Cursor _cursor;
  bool   _emptyFind;

  String _source;
  String _command;
  int    _seqid;


  /**
   * Process authentication packets
   */
  protocolStudyLgr(workPacket workUnit)
  {
    try
    {
      // Reset the response flags

      _session = workUnit.session;

      _session.releaseIsolate = false;
      _session.hasReply       = false;

      if(GDLogProtocol) print("Log Packet Processor: ${workUnit.workData}");

      // This packet type will occur when the server is used as a Flash XML Socket Server
      // This will not occur in a WebSocket environment. (the crossdomain.xml file is used instead)
      
      workUnit.workData = workUnit.workData.substring(0,workUnit.workData.length - 1);

      // unmarshall the command packet

      _packet  = JSON.decode(workUnit.workData, reviver:reviverFunc);

      if(GDLogProtocol) print("Decoded Log Packet: $_seqid - $_packet");

      _source  = _packet["source"];
      _command = _packet["command"];
      _seqid   = _packet['seqid'];

      if(GDLogProtocol) print(_packet.runtimeType);

      _GSharedDB.access("TED").then(processRequest, onError: onOpenError);
    }
    catch(err)
    {
      if(GDLogProtocol) print("Error in Protocol: $err");

      _session.Send('{"result":"fail", "source":"unknown", "command":"unknown", "Description":"Format error: Request Invalid"}\x00');
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


  //
  processRequest(result)
  {
    DbCollection coll;

    try
    {
      if(GDLogProtocol) print("readyToProcess:");
  
      switch(_command)
      {
        case "LOG_PACKET":
          coll = _GSharedDB.collection(_session._DataColl);
  
          _packet['document']["Created"]  = new DateTime.now().toUtc().toString();
  
          coll.insert(_packet['document']).then(insertSuccess, onError:insertError);
          break;
  
        case "LOG_TERMINATE":
          coll = _GSharedDB.collection(_session._AccountColl);
  
          _packet['document']["\$set"]["Modified"] = new DateTime.now().toUtc().toString();
  
          coll.update(_packet['query'], _packet['document']).then(updateSuccess, onError:updateError);
          break;
  
        case "LOG_PROGRESS":
          coll = _GSharedDB.collection(_session._AccountColl);
  
          _packet['document']["\$set"]["Modified"] = new DateTime.now().toUtc().toString();
  
          coll.update(_packet['query'], _packet['document']).then(updateSuccess, onError:updateError);
          break;
      }
    }
    catch(err)
    {
      print("protocolStudyLgr: processRequest Failed: $err");
    }
  }


  //
  insertSuccess(result)
  {
    try    
    {      
      _session.Send('{"seqid":"$_seqid", "result":"OK", "source":"$_source", "command":"$_command", "document":${JSON.encode(result, toEncodable:marshallObject)}}\x00');
    }
    catch(err)
    {
      print("protocolStudyLgr: insertSuccess Failed: $err");
    }
  }

  //
  insertError(result)
  {
    try    
    {      
      _session.Send('{"seqid":"$_seqid", "result":"fail", "source":"$_source", "command":"$_command", "document":"error", "message":${JSON.encode(result, toEncodable:marshallObject)}}\x00');
    }
    catch(err)
    {
      print("protocolStudyLgr: insertError Failed: $err");
    }
  }

  //
  updateSuccess(result)
  {
    try    
    {      
      _session.Send('{"seqid":"$_seqid", "result":"OK", "source":"$_source", "command":"$_command", "document":${JSON.encode(result, toEncodable:marshallObject)}}\x00');
    }
    catch(err)
    {
      print("protocolStudyLgr: updateSuccess Failed: $err");
    }
  }

  //
  updateError(result)
  {
    try    
    {      
      _session.Send('{"seqid":"$_seqid", "result":"fail", "source":"$_source", "command":"$_command", "document":"error", "message":${JSON.encode(result, toEncodable:marshallObject)}}\x00');
    }
    catch(err)
    {
      print("protocolStudyLgr: updateError Failed: $err");
    }
  }

  //
  onOpenError(err)
  {
    if(GDLogProtocol) print("Error on DB Open attempt:");

    try    
    {      
      _session.Send('{"seqid":"$_seqid", "result":"fail", "source":"unknown", "command":"db_open", "Description":"error accessing database"}\x00');
    }
    catch(err)
    {
      print("protocolStudyLgr: onOpenError Failed: $err");
    }
      
  }


  /**
   * Manage _id values as 24 character hex strings
   * Decode Reviver manages them on the way back
   */
  marshallObject(objValue)
  {
    try    
    {
      if(objValue is ObjectId)
      {
        return objValue.toHexString();
      }
    }
    catch(err)
    {
      print("protocolStudyLgr: marshallObject Failed: $err");
    }
      
    return objValue;
  }


  //*********************************************************************************************
  //*********************************************************************************************

}











