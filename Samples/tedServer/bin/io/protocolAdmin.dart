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

//## Sample Commands

//  String cmdString = '{"command":"insert","collection":"users","document":{"pwd":"guest"}}\x00';

//  String cmdString = '{"command":"find","collection":"users","query":{"\$query":{"pwd":"guest"}}}\x00';

//  String cmdString = '{"command":"find","collection":"users","query":{"user":{"\$regex":"t"}}}\x00';

//  String cmdString = '{"command":"insert","collection":"users","document":{"_id":"A","pwd":"guest"}}\x00';

//  String cmdString = '{"command":"update","collection":"users","query":{"_id":"A"}, "document":{"\$set":{"fieldB":"testguest2"}}}\x00';

//  String cmdString = '{"command":"update","collection":"users","query":{"_id":"A"}, "document":{"fieldB":"testguest2"}}\x00';

//  String cmdString = '{"command":"upsert","collection":"users","query":{"_id":"A"}, "document":{"_id":"A","field":"testguest2"}}\x00';

//  String cmdString = '{"command":"remove","collection":"users","query":{"_id":"C"}}\x00';

//  String cmdString = '{"command":"insertall","collection":"users", "document":[{"_id":"A","field":"test1"},{"_id":"B","field":"test1"},{"_id":"C","field":"test1"}]}\x00';


/**
 *
 *  db.runCommand({"$eval": "function(abool) { doc=db.getCollectionNames(); return doc; }", args: ["test"], nolock: true });
 * 
 *  db.runCommand({"eval": "function() { doc=db.getCollectionNames(); return doc; }" });
 * 
 * {
        "retval" : [
                "Study.ASVR",
                "Study.ASVR.Data",
                "TED2_11_13.PRETST",
                "TED2_11_13.PSTTST",
                "TED2_11_13.TUTOR",
                "TED2_11_13.phases",
                "auth_groups",
                "bootloaders",
                "classes",
                "features",
                "institutions",
                "interfaces",
                "libraries",
                "loaders",
                "modules",
                "null",
                "spellers",
                "studies",
                "study.groups",
                "system.indexes",
                "users"
        ],
        "ok" : 1
}
 * 
 *   db.runCommand( { listDatabases: 1 } )
{
       "databases" : [
               {
                       "name" : "admin",
                       "sizeOnDisk" : 218103808,
                       "empty" : false
               },
               {
                       "name" : "local",
                       "sizeOnDisk" : 83886080,
                       "empty" : false
               },
               {
                       "name" : "mongo_dart-test",
                       "sizeOnDisk" : 218103808,
                       "empty" : false
               },
               {
                       "name" : "TED",
                       "sizeOnDisk" : 218103808,
                       "empty" : false
               },
               {
                       "name" : "ted2",
                       "sizeOnDisk" : 218103808,
                       "empty" : false
               },
               {
                       "name" : "test",
                       "sizeOnDisk" : 218103808,
                       "empty" : false
               }
       ],
       "totalSize" : 1174405120,
       "ok" : 1
}
 *
 *
*/



part of tedServer;


class protocolAdmin
{
  // Reset the response flags

  sessionStatus _session;

  Map    _packet;
  Cursor _cursor;
  bool   _emptyFind;

  String _source;
  String _command;
  String _database;


  protocolAdmin(workPacket workUnit)
  {
    // Reset the response flags

    _session = workUnit.session;

    _session.releaseIsolate = false;
    _session.hasReply       = false;

    if(GDProtocol) print("packetProcessor: ${workUnit.workData}");

    // This packet type will occur when the server is used as a Flash XML Socket Server
    // This will not occur in a WebSocket environment. (the crossdomain.xml file is used instead)

    try
    {
      workUnit.workData = workUnit.workData.substring(0,workUnit.workData.length - 1);

      // unmarshall the command packet

      _packet  = JSON.decode(workUnit.workData, reviver:reviverFunc);

      if(GDProtocol) print("Decoded Packet: $_packet");

      _source  = _packet["source"];
      _command = _packet["command"];

      if(_packet["database"] != null) _database = _packet["database"];
                                 else _database = "TED";

      if(GDProtocol) print(_packet.runtimeType);

       _GSharedDB.access(_database).then(processRequest, onError: onOpenError);
    }
    catch(err)
    {
      print("protocolAdmin: Error in Protocol: $err");

      _session.Send('{"result":"fail", "database":"unknown", "source":"unknown", "command":"unknown", "Description":"Format error: Request Invalid"}\x00');
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



  //
  processRequest(result)
  {
    DbCollection coll;

    if(GDProtocol) print("readyToProcess:");

    switch(_packet['command'])
    {
      case "sendmail":
        
        if(GDProtocol) print("sendMail Requested: ${_packet['message']}");
                
        try
        {
          var options = new GmailSmtpOptions()
              ..username = 'klahrlab@gmail.com'
              ..password = 'klahr#314159 '; // Password changed due to hack 'klahr123*ted'; 
          
          // Create our email transport.
          var emailTransport = new SmtpTransport(options);
          
          // Create our mail/envelope.
          var envelope = new Envelope()
           ..from = 'TED Tutor <KlahrLab@gmail.com>'
           ..subject =  _packet['subject']
           
           //..attachments.add(new Attachment(file: new File('path/to/file')))
           ..text = _packet['message'];

          switch(_packet['sendto'].toLowerCase())
          {
            case "user":
              envelope.recipients.add(_session._User);
              
              if(GDProtocol) print(_session._User);
              break;
              
            case "admin":
            default:  // admin
              envelope.recipients.add('klahrlab@gmail.com');
              break;
          }
          
           //..text = 'This is the user feedback';
           //..html = '<h1>Test</h1><p>Hey!</p>';
          
          // Email it.
          emailTransport.send(envelope)
           .then(sendMailComplete)
           .catchError(sendMailError);
        }
        catch(err)
        {
          sendMailError(err);
        }
        break;
        
      case "dbcommand":
        try
        {
          _GSharedDB.dbCommand(_packet['query']).then(dbCommandComplete, onError:dbCommandError);
        }
        catch(err)
        {
          dbCommandError(err);
        }

        break;

      case "find":
        try
        {
          coll = _GSharedDB.collection(_packet['collection']);
  
          _cursor = coll.find(_packet['query']);
          
          // Note: look inside mongo_darts cursor.dart to see how this works
          
          _cursor.fields = _packet['fields'];
  
          _emptyFind = true;
  
          _cursor.forEach(queryResult).then(findComplete, onError:findError);
        }
        catch(err)
        {
          findError(err);
        }
        break;

      case "insert":
        try
        {
            coll = _GSharedDB.collection(_packet['collection']);
    
            _packet['document']["Created"]  = new DateTime.now().toUtc().toString();
            _packet['document']["Modified"] = new DateTime.now().toUtc().toString();
            _packet['document']["isActive"] = true;
    
            coll.insert(_packet['document']).then(insertSuccess, onError:insertError);
        }
        catch(err)
        {
          insertError(err);
        }
        break;

      case "insertall":
        try
        {
          coll = _GSharedDB.collection(_packet['collection']);
  
          coll.insertAll(_packet['document']).then(insertSuccess, onError:insertError);
        }
        catch(err)
        {
          insertError(err);
        }
        break;

      case "update":
      case "recycle":
      case "recover":
        try
        {
          coll = _GSharedDB.collection(_packet['collection']);
  
          _packet['document']["\$set"]["Modified"] = new DateTime.now().toUtc().toString();
  
          coll.update(_packet['query'], _packet['document']).then(updateSuccess, onError:updateError);
        }
        catch(err)
        {
          updateError(err);
        }
        break;

      case "unset":
        try
        {
          coll = _GSharedDB.collection(_packet['collection']);
    
          coll.update(_packet['query'], _packet['document']).then(updateSuccess, onError:updateError);
        }
        catch(err)
        {
          updateError(err);
        }
        break;

      case "upsert":
        try
        {
          coll = _GSharedDB.collection(_packet['collection']);
  
          _packet['document']["Created"]  = new DateTime.now().toUtc().toString();
          _packet['document']["Modified"] = new DateTime.now().toUtc().toString();
          _packet['document']["isActive"] = true;
  
          coll.update(_packet['query'], _packet['document'], upsert:true).then(updateSuccess, onError:updateError);
        }
        catch(err)
        {
          updateError(err);
        }
        break;

      case "remove":
        try
        {
          coll = _GSharedDB.collection(_packet['collection']);
  
          coll.remove(_packet['query']).then(removeSuccess, onError:removeError);
        }
        catch(err)
        {
          removeError(err);
        }
        break;
    }
  }

  
  String encodeResult(result) 
  {
    String encoded;  
  
    try
    {
      encoded = JSON.encode(result, toEncodable:marshallObject);
    }
    catch(err)
    {
      encoded = "ERROR_encoding_failed";
    }
    
    return encoded;
  }
  
  
  //
  sendMailComplete(result)
  {
    if(GDProtocol) print("sendMail Complete: $result");

    _session.Send('{"result":"OK", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
  }

  //
  sendMailError(result)
  {
    if(GDProtocol) print("sendMail Failure: $result");

    _session.Send('{"result":"fail", "source":"$_source", "command":"$_command", "message":${encodeResult(result)}}\x00');
  }


  //
  dbCommandComplete(result)
  {
    if(GDProtocol) print("dbCommand Complete: $result");

    _session.Send('{"result":"OK", "database":"$_database", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
  }

  //
  dbCommandError(result)
  {
    if(GDProtocol) print("dbCommand Failure: $result");

    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "message":${encodeResult(result)}}\x00');
  }


  //
  queryResult(result)
  {
    if(GDProtocol) print(result.runtimeType);
    if(GDProtocol) print("record: $result");

    _emptyFind = false;

    // If cursor is exhausted we release the isolate otherwise hang on to it

    _session.Send('{"result":"OK", "done":"${_cursor.items.isEmpty.toString()}", "database":"$_database", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00', _cursor.items.isEmpty);
  }

  //
  findComplete(result)
  {
    if(GDProtocol) print("Find Complete: $result");

    if(_emptyFind)
      _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "description":"empty", "message":${encodeResult(result)}}\x00');
  }

  //
  findError(result)
  {
    if(GDProtocol) print("Find Failure: $result");

    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "message":${encodeResult(result)}}\x00');
  }


  //
  insertSuccess(result)
  {
    _session.Send('{"result":"OK", "database":"$_database", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
  }

  //
  insertError(result)
  {
    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }

  //
  updateSuccess(result)
  {
    if(GDProtocol) print("update Complete: $result");
    
    _session.Send('{"result":"OK", "database":"$_database", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
  }

  //
  updateError(result)
  {
    if(GDProtocol) print("update Failed: $result");
    
    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }

  //
  removeSuccess(result)
  {
    if(GDProtocol) print("remove Complete: $result");
    
    _session.Send('{"result":"OK", "database":"$_database", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
  }

  //
  removeError(result)
  {
    if(GDProtocol) print("remove Failed: $result");
    
    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }


  //
  onOpenError(err)
  {
    if(GDProtocol) print("Error on Authentication attempt:");

    _session.Send('{"result":"fail", "source":"unknown", "command":"db_open", "Description":"error accessing database"}\x00');
  }


  /**
   * Manage _id values as 24 character hex strings
   * Decode Reviver manages them on the way back
   */
  marshallObject(Object objValue)
  {
    if(objValue is ObjectId)
    {
      return objValue.toHexString();
    }

    return objValue;
  }

}











