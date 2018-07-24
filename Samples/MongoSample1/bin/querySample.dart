import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
//import 'package:mongo_dart_query/mongo_dart_query.dart';



Map    _packet;
Cursor _cursor;
bool   _emptyFind;
var    _reply;

Db       Database;

Stopwatch      _taskTimer;

JsonCodec JSON = const JsonCodec();


main()
{
//  String cmdString = '{"command":"insert","collection":"users","document":{"pwd":"guest"}}\x00';
//
//  String cmdString = '{"source":"schoolview","command":"update","collection":"institutions","query":{"_id":"5277c0c282cf932e3e3615ef"}, "document":{"\$set":{"Notes":"Different Test"}}}\x00';

//  String cmdString = '{"command":"find","collection":"institutions","query":{"\$query":{"_id":"5276ad0fb0c3360a41fae195"}}}\x00';

//  String cmdString = '{"command":"find","collection":"conditions","query":{"_id":"ted2high"}}\x00';

  String cmdString = '{"command":"find","collection":"users","query":{}}\x00';

//  String cmdString = '{"command":"find","collection":"users","query":{"\$query":{"pwd":"guest"}}}\x00';

//  String cmdString = '{"command":"find","collection":"users","query":{"user":{"\$regex":"t"}}}\x00';

//  String cmdString = '{"command":"insert","collection":"users","document":{"_id":"A","pwd":"guest"}}\x00';

//  String cmdString = '{"command":"update","collection":"institutions","query":{"_id":"527a6c8f82cf932e3e362282"}, "document":{"\$set":{"Address.City":"Montreal"}}}\x00';

//  String cmdString = '{"command":"update","collection":"users","query":{"_id":"A"}, "document":{"\$set":{"fieldB":"testguest2"}}}\x00';

//  String cmdString = '{"command":"update","collection":"users","query":{"_id":"A"}, "document":{"fieldB":"testguest2"}}\x00';

//  String cmdString = '{"command":"upsert","collection":"users","query":{"_id":"A"}, "document":{"_id":"A","field":"testguest2"}}\x00';

//  String cmdString = '{"command":"remove","collection":"users","query":{"_id":"C"}}\x00';

//  String cmdString = '{"command":"insertall","collection":"users", "document":[{"_id":"A","field":"test1"},{"_id":"B","field":"test1"},{"_id":"C","field":"test1"}]}\x00';

//  String cmdString = '{"command":"insert","collection":"institutions", "document":{"District":"Pittsburgh Catholic Schools", "Name":"Sister Thea Bowman Academy", "Name_nn":"St James", "Classification":"Study Location", "Address":{"Street":"unknown", "City":"Pittsburgh", "State":"PA", "Country":"USA", "ZipCode":"15233"}, "_contact":"", "Contact_nn":"Sister Mary Margaret","Notes":"test note"}}\x00';

//  String cmdString = '{"command":"recycle","collection":"institutions","query":{"_id":"527a6c8f82cf932e3e362282"}, "document":{"\$set":{"isActive":false}}}\x00';

//  String cmdString = '{"command":"recycle","collection":"institutions","query":{}, "document":{"\$set":{"isActive":true}}}\x00';

  //setStartTime();

   
  protocolCommand(cmdString);
}


protocolCommand(String workUnit)
{
  //protocol.releaseIsolate = false;
  //protocol.hasReply       = false;

  // If this is a Flash policy request - handle it first

  print("packetProcessor: ${workUnit}");

  // This packet type will occur when the server is used as a Flash XML Socket Server
  // This will not occur in a WebSocket environment. (the crossdomain.xml file is used instead)

  try
  {
    _packet = JSON.decode(workUnit.substring(0,workUnit.length - 1), reviver:reviverFunc);

    var URI = "mongodb://127.0.0.1/" + "TED";

    Database = new Db(URI);

    Database.open(writeConcern: WriteConcern.ACKNOWLEDGED ).then(processRequest, onError: onOpenError);
  }
  catch(err)
  {
    print("Error in request: $err");

    //protocol.Send('Authentication Request Denied\n\x00');
  }
}

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

  print("readyToProcess: $_packet");

  switch(_packet['command'])
  {
    case "find":
        coll = Database.collection(_packet['collection']);

        _cursor = coll.find(_packet['query']);

        _emptyFind = true;

        _cursor.forEach(queryResult).then(findComplete, onError:findError);
        break;

    case "insert":
      coll = Database.collection(_packet['collection']);

      print(_packet);
      
      _packet['document']["Created"]  = new DateTime.now().toUtc().toString();
      _packet['document']["Modified"] = new DateTime.now().toUtc().toString();
      _packet['document']["isActive"] = true;
      
      print(_packet);
      
      coll.insert(_packet['document']).then(insertSuccess, onError:insertError);
      break;

    case "insertall":
      coll = Database.collection(_packet['collection']);

      coll.insertAll(_packet['document']).then(insertSuccess, onError:insertError);
      break;

    case "update":
    case "recycle":
    case "recover":
      coll = Database.collection(_packet['collection']);

      print(_packet);
      
      _packet['document']["\$set"]["Modified"] = new DateTime.now().toUtc().toString();
      
      print(_packet);
      
      coll.update(_packet['query'], _packet['document']).then(updateSuccess, onError:updateError);
      break;

    case "upsert":
      coll = Database.collection(_packet['collection']);

      _packet['document']["Created"]  = new DateTime.now().toUtc().toString();
      _packet['document']["Modified"] = new DateTime.now().toUtc().toString();
      _packet['document']["isActive"] = true;
      
      coll.update(_packet['query'], _packet['document'], upsert:true).then(updateSuccess, onError:updateError);
      break;

    case "remove":
      coll = Database.collection(_packet['collection']);

     coll.remove(_packet['query']).then(removeSuccess, onError:removeError);
      break;
  }
}

//
queryResult(result)
{
  print(result.runtimeType);
  print("record: ${JSON.encode(result, toEncodable:marshallObject)}");

  _emptyFind = false;

  if(_cursor.items.isEmpty)
  {
    print('end of collection');
    Database.close();
  }
}

//
findComplete(result)
{
  if(_emptyFind)
    print('{"ack":"find", "document":"empty"}\x00');

  Database.close();
}

//
findError(result)
{
  print("Find Failure: $result");

  Database.close();
}


//
insertSuccess(result)
{
  print("Success: ${JSON.encode(result, toEncodable:marshallObject)}");

  Database.close();
}

//
insertError(result)
{
  print("Failure: $result");

  Database.close();
}

//
updateSuccess(result)
{
  print("Success: ${JSON.encode(result, toEncodable:marshallObject)}");

  Database.close();
}

//
updateError(result)
{
  print("Failure: $result");

  Database.close();
}

//
removeSuccess(result)
{
  print("Success: ${JSON.encode(result, toEncodable:marshallObject)}");

  Database.close();
}

//
removeError(result)
{
  print("Failure: $result");

  Database.close();
}


//
onOpenError(err)
{
  print("Error on Authentication attempt:");

  //protocol.Send('Authentication Request Denied\n\x00');
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


marshallObject(Object objValue)
{
  if(objValue is ObjectId)
  {
    return objValue.toHexString();
  }

  return objValue;
}











