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


class protocolStudyLdr
{
  sessionStatus _session;

  String _Prequest;
  String _request_type;

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
  protocolStudyLdr(workPacket workUnit)
  {
    // Reset the response flags

    _session = workUnit.session;

    if(GDProtocol) print("Passed Protocol: $_session");

    _session.releaseIsolate = false;
    _session.hasReply       = false;

    // If this is a Flash policy request - handle it first

    if(GDProtocol) print("packetProcessor: ${workUnit.workData}");

    try
    {
      workUnit.workData = workUnit.workData.substring(0,workUnit.workData.length - 1);

      if(GDProtocol) print(workUnit.workData);

      var dataObj = JSON.decode(workUnit.workData, reviver:reviverFunc);

      if(GDProtocol) print(dataObj.runtimeType);
      if(GDProtocol) print("Packet:" + "Study Loader Request: $dataObj");

      _request_type = dataObj["request_type"];

      switch(_request_type)
      {
        // This builds a loader image based upon the users study profile

        case 'STUDY_LOADER_REQUEST':

          // Switch to the requested protocol - all future traffic on this socket will be managed by this
          // protocol unless/until another PROTOCOL_SWITCH is requested.

          if(dataObj["protocol_request"] != null)
          {
            _session.protocolID = protocolValid.validate(dataObj["protocol_request"].toUpperCase());

            if(GDProtocol) print("Protocol Switch: ${_session.protocolID}");
          }

          _GSharedDB.access("TED").then(buildLoader, onError: onAccessError);

          break;

        default:
          if(GDProtocol) print("Unrecognised Study Loader Protocol Packet: ${workUnit.workData}");

          _session.Send('{"result":"fail", "Description":"Study Loader Request Denied"}\x00');
          break;
      }
    }
    catch(err)
    {
      if(GDProtocol) print("Error in Protocol: $err");

      _session.Send('{"result":"fail", "Description":"Study Loader Request Denied"}\x00');
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
   *  Here we decompose the users progress through a study and return the appropriate loader for
   *  the phase of the study they are in.
   *
   *  Their profile is loaded in the group authentication phase
   *    {
   *      "_id":"jamesfr",
   *      "firstname":"fred",
   *      "mi":"d",
   *      "lastname":"james",
   *      "ability":"low",
   *      "study":"TED2_11_13",
   *      "phases":
   *      {
   *        phase.seqndx:{"_phase":phase._id, "_loader":phase.loader, "_features":features._id, "progress":<value>, "stateData":{obj}},
   *        phase.seqndx:{"_phase":phase._id, "_loader":phase.loader, "_features":features._id, "progress":<value>, "stateData":{obj}}
   *        ...
   *      }
   *    }
   *
   */
  buildLoader(result)
  {
    // This protocol is designed to return a fully qualified loader environment for a research study

    bool ldrFound = false;

    try
    {
      profile = JSON.decode(_session.profile);
    }
    catch(err)
    {
      if(GDProtocol) print("JSON error: profile invalid");
    }

    // Build a response packet - basic packet is the account object

    _reply = new Map();

    _reply["type"]   = "Studyloader";
    _reply["result"] = "success";

    // Locate the next phase in the study that is either unstarted or inprogress
    // and load its image.  If none left load a default done FLEX loader

    //## TODO : Need to use " for each " type statement here 
    //          If there is an uninitialized phase you get an exception as "progress" object won't exist
    try
    {
      // phase ndx's are 1-based
      
      for(var i1 = 0 , num=1 ; i1 < profile['phases'].length ; i1++, num++)
      {
        progress = profile['phases']['$num']['progress'];
  
        if(progress == _READY || progress == _INPROGRESS)
        {
          ldrFound = true;
  
          // Attach the current phase data as the profile
  
          _reply["profile"]       = profile['phases']['$num'];
          _reply["profile_Index"] = "$num";
  
          // record the foreign keys to the loader and features collections - will be replaced with actual documents
          // in subsequent queries
  
          _reply['_loader']   = profile['phases']['$num']['_loader'];
          _reply['_features'] = profile['phases']['$num']['_features'];
  
          // now build the loader
  
          _GSharedDB.collection("loaders").findOne(where.eq("_id", _reply['_loader'])).then(onLoader, onError: onAccessError );
  
          break;
        }
      }
    }
    catch(err)
    {
      print("uninitialized phase attempted: ${profile['userId']}");
      
      _GSharedDB.collection("loaders").findOne(where.eq("_id",'studyComplete')).then(onLoader, onError: onAccessError );
    }
    
    // If all phases are complete and no terminal loader is defined - load the default terminal flex loader defined in tedinitialize.dart

    if(!ldrFound)
    {
      _GSharedDB.collection("loaders").findOne(where.eq("_id",'studyComplete')).then(onLoader, onError: onAccessError );
    }
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
      else
      {
        _GSharedDB.collection("libraries").findOne(where.eq("_id",_reply["_loader"]["_library"])).then(onLibrary, onError: onAccessError );
      }
    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid");

      _session.Send('{"result":"fail", "Description":"Loader encoding invalid"}\x00');
    }
  }


  //
  onLibrary(result)
  {
    if(GDProtocol) print(result.runtimeType);
    if(GDProtocol) print("Library:" + "record: $result");

    try
    {
      // now add the loader to the response packet

      _reply["_loader"]["_library"] = result;

      // If the loader is flash domain it has all 4 - _library _module _speller _xface
      // They need to be queried and added to the response packet

      _GSharedDB.collection("modules").findOne(where.eq("_id",_reply["_loader"]["_module"])).then(onModule, onError: onAccessError );
    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid");

      _session.Send('{"result":"fail", "Description":"library encoding invalid"}\x00');
    }
  }


  //
  onModule(result)
  {
    if(GDProtocol) print(result.runtimeType);
    if(GDProtocol) print("Module:" + "record: $result");

    try
    {
      // now add the loader to the response packet

      _reply["_loader"]["_module"] = result;

      // If the loader is flash domain it has all 4 - _library _module _speller _xface
      // They need to be queried and added to the response packet

      _GSharedDB.collection("spellers").findOne(where.eq("_id",_reply["_loader"]["_speller"])).then(onSpeller, onError: onAccessError );
    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid");

      _session.Send('{"result":"fail", "Description":"module encoding invalid"}\x00');
    }
  }

  //
  onSpeller(result)
  {
   if(GDProtocol) print(result.runtimeType);
   if(GDProtocol) print("Speller:" + "record: $result");

   try
    {
      // now add the loader to the response packet

      _reply["_loader"]["_speller"] = result;

      // If the loader is flash domain it has all 4 - _library _module _speller _xface
      // They need to be queried and added to the response packet

      _GSharedDB.collection("features").findOne(where.eq("_id",_reply["_features"])).then(onFeature, onError: onAccessError );
    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid");

      _session.Send('{"result":"fail", "Description":"Speller encoding invalid"}\x00');
    }
  }

  //
  onFeature(result)
  {
   if(GDProtocol) print(result.runtimeType);
   if(GDProtocol) print("Feature:" + "record: $result");

   try
    {
      // now add the loader to the response packet

      _reply["_features"] = result['features'];

      // If the loader is flash domain it has all 4 - _library _module _speller _xface
      // They need to be queried and added to the response packet

      _GSharedDB.collection("interfaces").findOne(where.eq("_id",_reply["_loader"]["_xface"])).then(onInterface, onError: onAccessError );
    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid");

      _session.Send('{"result":"fail", "Description":"feature encoding invalid"}\x00');
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

      _session.Send(JSON.encode(_reply, toEncodable:marshallObject) + '\x00');
    }
    catch(err)
    {
      if(GDProtocol) print("Loader encoding invalid: + $err");

      _session.Send('{"result":"fail", "Description":"interface encoding invalid"}\x00');
    }
  }


  //
  onAccessError(err)
  {
    if(GDProtocol) print("Error on Authentication attempt:");

    _session.Send('{"result":"fail", "Description":"db error"}\x00');
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











