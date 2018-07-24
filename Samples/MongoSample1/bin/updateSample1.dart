import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

main()
{
  Map _packet;
  Db db = new Db('mongodb://127.0.0.1/TED');

  //String cmdString = '{"command":"update","collection":"studies","query":{"project":"TED2"}, "document":{"\$set":{"phases.1.name":"PRE TEST TEST TEST"}}}\x00';
  
  String cmdString = '{"source":"classlistview","command":"update","collection":"classList.ASVR","query":{"_id":"KardellKi"}, "document":{"\$set":{"phases.1.phase":"PRETST","phases.1.progress":"READY","phases.1.condition":"PRETESTA"}}}\x00';  
  
  simpleUpdate(String cmdString)
  {
    
    _packet = JSON.decode(cmdString.substring(0,cmdString.length - 1), reviver:reviverFunc);

    
    DbCollection coll = db.collection( _packet['collection']);

    _packet['document']["\$set"]["Modified"] = new DateTime.now().toUtc().toString();
    
    print(_packet);
    
    coll.update(_packet['query'], _packet['document']).then(printResult, onError:onQueryError);
  };

  db.open().then((c)=>simpleUpdate(cmdString));
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


printResult(result)
{
  try
  {
    print("record: $result");
  }
  catch(err)
  {
    print('Error caught: $err');
  }
}

onQueryError(err)
{
  print("error: " + err);
}


