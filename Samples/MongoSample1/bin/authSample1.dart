import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';


String  _policyRequest = "<policy-file-request/>\x00";    // Note the null terminator

// Reset the response flags

String _User;
String _Password;

var    _reply;

Db       Database;

Stopwatch      _taskTimer;


main()
{

  String authStr = '{"request_type":"DB_AUTHENTICATE","user":"' + "tedroot" + '","pwd":"' + "klahr123*ted" + '"}\x00';
//  String authStr = '{"request_type":"DB_AUTHENTICATE","user":"' + "ted" + '","pwd":"' + "guest" + '"}\x00';

  setStartTime();

  protocolAuth(authStr);


}


protocolAuth(String workUnit)
{
  //protocol.releaseIsolate = false;
  //protocol.hasReply       = false;

  // If this is a Flash policy request - handle it first

  print("packetProcessor: ${workUnit}");

  // This packet type will occur when the server is used as a Flash XML Socket Server
  // This will not occur in a WebSocket environment. (the crossdomain.xml file is used instead)

  if(workUnit == _policyRequest)
  {
    print("Policy Request Received");

//        protocol.Send(
//                    '<?xml version="1.0"?>\n'
//                    '<!-- DART: TEDServer Cross Domain Access -->\n'
//                    '<cross-domain-policy>\n'
//                    '  <site-control permitted-cross-domain-policies="all"/>\n'
//                    '  <allow-access-from domain="*" to-ports="12000-12004"/>\n'
//                    '</cross-domain-policy>\n\x00');
  }
  else
  {
    try
    {
      workUnit = workUnit.substring(0,workUnit.length - 1);

      var authObj = JSON.decode(workUnit);

      print(authObj.runtimeType);
      print("Authenticating: $authObj");

      switch(authObj["request_type"])
      {
        case 'DB_AUTHENTICATE':
          _User     = authObj["user"].toLowerCase();
          _Password = authObj["pwd"].toLowerCase();

          var URI = "mongodb://127.0.0.1/" + "TED";

          Database = new Db(URI);

          Database.open(writeConcern: WriteConcern.ACKNOWLEDGED ).then(readyToAuthenticate, onError: onAuthError);

          break;

        default:
          print("unrecognised Authentication Protocol: ${workUnit}");

          //protocol.Send('Authentication Request Denied\n\x00');
          break;
      }
    }
    catch(err)
    {
      print("Error in Protocol: $err");

      //protocol.Send('Authentication Request Denied\n\x00');
    }
  }
}


//
readyToAuthenticate(result)
{
  DbCollection coll;


  print("readyToAuthenticate:");

  coll = Database.collection("users");

  coll.findOne(where.eq("user",_User).fields(["user","pwd","_condition","_loader","isActive"])).then(onAuthenticate, onError: onAuthError );
}


//
onAuthenticate(result)
{
  print(result.runtimeType);
  print("record: $result");

  if((result != null) && (result["pwd"] == _Password))
  {
    try
    {
      // Build a response packet - basic packet is the account object

      _reply = result;

      _reply["result"]      = "success";
      _reply["Description"] = "Access Granted";

      // now build the loader

      Database.collection("loaders").findOne(where.eq("_id",_reply["_loader"])).then(onLoader, onError: onAuthError );
    }
    catch(err)
    {
      print("Authentication result encode failed");

      //protocol.Send('{"result":"fail", "Description":"Authentication Request Denied}"\x00');
    }
  }
  else
  {
    //protocol.Send('{"result":"fail", "Description":"Authentication Request Denied}"\x00');
  }

}

//
onLoader(result)
{
  print(result.runtimeType);
  print("record: $result");

  try
  {
    // now add the loader to the response packet

    _reply["_loader"] = result;

    // If the loader is a flex domain loader, it only has an interface link

    if(result["domain"] == "flex")
    {
      Database.collection("interfaces").findOne(where.eq("_id",_reply["_loader"]["_xface"])).then(onInterface, onError: onAuthError );
    }

    // If the loader is flash domain it has all 4 - _library _module _speller _xface
    // They need to be queried and added to the response packet

    else
    {
      Database.collection("libraries").findOne(where.eq("_id",_reply["_loader"]["_library"])).then(onLibrary, onError: onAuthError );
    }
  }
  catch(err)
  {
    print("Loader encoding invalid");

    //protocol.Send('{"result":"fail", "Description":"Loader encoding invalid}"\x00');
  }
}

//
onLibrary(result)
{
  print(result.runtimeType);
  print("record: $result");

  try
  {
    // now add the loader to the response packet

    _reply["_loader"]["_library"] = result;

    // If the loader is flash domain it has all 4 - _library _module _speller _xface
    // They need to be queried and added to the response packet

    Database.collection("modules").findOne(where.eq("_id",_reply["_loader"]["_module"])).then(onModule, onError: onAuthError );
  }
  catch(err)
  {
    print("Loader encoding invalid");

    //protocol.Send('{"result":"fail", "Description":"Loader encoding invalid}"\x00');
  }
}


//
onModule(result)
{
  print(result.runtimeType);
  print("record: $result");

  try
  {
    // now add the loader to the response packet

    _reply["_loader"]["_module"] = result;

    // If the loader is flash domain it has all 4 - _library _module _speller _xface
    // They need to be queried and added to the response packet

    Database.collection("spellers").findOne(where.eq("_id",_reply["_loader"]["_speller"])).then(onSpeller, onError: onAuthError );
  }
  catch(err)
  {
    print("Loader encoding invalid");

    //protocol.Send('{"result":"fail", "Description":"Loader encoding invalid}"\x00');
  }
}

//
onSpeller(result)
{
  print(result.runtimeType);
  print("record: $result");

  try
  {
    // now add the loader to the response packet

    _reply["_loader"]["_speller"] = result;

    // If the loader is flash domain it has all 4 - _library _module _speller _xface
    // They need to be queried and added to the response packet

    print(_reply["_condition"]);

    Database.collection("conditions").findOne(where.eq("_id",_reply["_condition"])).then(onCondition, onError: onAuthError );
  }
  catch(err)
  {
    print("Loader encoding invalid");

    //protocol.Send('{"result":"fail", "Description":"Loader encoding invalid}"\x00');
  }
}

//
onCondition(result)
{
  print(result.runtimeType);
  print("record: $result");

  try
  {
    // now add the loader to the response packet

    _reply["_condition"] = result;

    // If the loader is flash domain it has all 4 - _library _module _speller _xface
    // They need to be queried and added to the response packet

    Database.collection("interfaces").findOne(where.eq("_id",_reply["_loader"]["_xface"])).then(onInterface, onError: onAuthError );
  }
  catch(err)
  {
    print("Loader encoding invalid");

    //protocol.Send('{"result":"fail", "Description":"Condition encoding invalid"}\x00');
  }
}

//
onInterface(result)
{
  print(result.runtimeType);
  print("record: $result");

  try
  {
    // now add the loader to the response packet

    _reply["_loader"]["_xface"] = result;

    print("Elapsed Time: ${getElapsedTime()}");

    // If the loader is flash domain it has all 4 - _library _module _speller _xface
    // They need to be queried and added to the response packet

    String outCome = JSON.encode(_reply) + '\x00';

    print(outCome);
  }
  catch(err)
  {
    print("Loader encoding invalid" + err);

    //protocol.Send('{"result":"fail", "Description":"Loader encoding invalid}"\x00');
  }
}


//
onAuthError(err)
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












