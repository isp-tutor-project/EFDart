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


String  _policyRequest = "<policy-file-request/>\x00";    // Note the null terminator

class protocolAuth
{
  // Reset the response flags

  sessionStatus session;

  String _Prequest;
  String _request_type;

  var    _reply;

  /**
   * Process authentication packets
   */
  protocolAuth(workPacket workUnit)
  {
    // Capture the session status

    session = workUnit.session;

    if(GDAuthProtocol) print("Passed Protocol: $session");

    session.releaseIsolate = false;
    session.hasReply       = false;

    // If this is a Flash policy request - handle it first

    if(GDAuthProtocol) print("packetProcessor: ${workUnit.workData}");

    // This packet type will occur when the server is used as a Flash XML Socket Server
    // This will not occur in a WebSocket environment. (the crossdomain.xml file is used instead)

    if(workUnit.workData == _policyRequest)
    {
      if(GDPolicyProtocol) print("Policy Request Received");

      session.Send(
                    '<?xml version="1.0"?>\n'
                    '<!-- DART: TEDServer Cross Domain Access -->\n'
                    '<cross-domain-policy>\n'
                    '  <site-control permitted-cross-domain-policies="all"/>\n'
                    '  <allow-access-from domain="*" to-ports="80,12000-12004"/>\n'
                    '</cross-domain-policy>\n\x00');
    }
    else
    {

      // Authentication packets are in this form
      // {"request_type":"DB_AUTHENTICATE","user":"' + _username + '","pwd":"' + _password + '", "protocol_request":"ADMIN.1.0"}

      // InterfaceRequest packets are in this form
      // {"request_type":"ENV_SETTINGS", "protocol_request":"AUTHENTICATE.1.0"}

      try
      {
        workUnit.workData = workUnit.workData.substring(0,workUnit.workData.length - 1);

        if(GDAuthProtocol) print(workUnit.workData);

        var dataObj = JSON.decode(workUnit.workData, reviver:reviverFunc);

        if(GDAuthProtocol) print(dataObj.runtimeType);
        if(GDAuthProtocol) print("Packet:" + "Authenticating: $dataObj");

        _request_type = dataObj["request_type"];

        // Prep for requested protocol - after authentication all future traffic on this socket will
        // be managed by the accepted protocol unless/until another PROTOCOL_SWITCH is requested.

        if(dataObj["protocol_request"] != null)
        {
          if(GDAuthProtocol) print("Protocol Requested: ${dataObj["protocol_request"].toUpperCase()}}");

          _Prequest = protocolValid.validate(dataObj["protocol_request"].toUpperCase());

          if(GDAuthProtocol) print("Protocol Accepted: ${_Prequest}");
        }


        // NOTE: We don't want to allow arbitrary queries in this protocol as it would make the DB
        //       vulnerable to unauthenticated attacks.

        // This first step is to gain access to a shared DB connection :  (common to all requests)

        switch(_request_type)
        {
          // This expects a request of the form
          //
          //    {"request_type":"BOOT_SETTINGS", "override":_initFragment }

          case 'BOOT_SETTINGS':

            session._protocolPending = false;    // reset pending flag for valid opcodes

            _GSharedDB.access("TED").then(readyToQueryBootLoader, onError: onAccessError);

            break;

          // This expects a request of the form
          //
          //  {"request_type":"GROUP_QUERY", "groupid":SuserPW.text.toUpperCase()}

          case 'GROUP_QUERY':

            session._protocolPending = false;   // reset pending flag for valid opcodes

            session._Password = dataObj["groupid"].toUpperCase();

            _GSharedDB.access("TED").then(readyToQueryGroupID_TYPE1, onError: onAccessError);

            break;


          // This method authenticates against the group collection authenticated at an earlier step - GROUP_QUERY
          //
          //  {
          //        "request_type":"STUDY_AUTHENTICATE",
          //                "user":SuserID.text.toLowerCase(),
          //             "groupid":SuserPW.text.toLowerCase(),
          //    "protocol_request":"TEDLOG.1.0"
          //  }

          case 'STUDY_AUTHENTICATE':

            session._protocolPending = false;    // reset pending flag for valid opcodes
            
            // Manufacture study specific account and data collection names.  
            // Note: these override the collections set in the group authentication (group auth is deprecated)
            
            session._StudyGroup  = dataObj["groupid"].toUpperCase();
            
            session._AccountColl = 'Study.' + session._StudyGroup;
            session._DataColl    = 'Study.' + session._StudyGroup + '.Data';

            session._User        = dataObj["user"].toLowerCase();
            
            _GSharedDB.access("TED").then(studyAuthenticate, onError: onStudyAuthError);

            break;


            // This method currently authenticates against the Users collection authenticated at an earlier step - GROUP_QUERY
            //
            //  {
            //        "request_type":"DB_AUTHENTICATE",
            //                "user":SuserID.text.toLowerCase(),
            //                 "pwd":SuserPW.text.toLowerCase(),
            //    "protocol_request":"ADMIN.1.0"
            //  }

          case 'DB_AUTHENTICATE':

            session._protocolPending = false;    // reset pending flag for valid opcodes

            // Support passing authentication collection - Jul 2 2014 - for teachers public UI
            // This allows collections other than users to authenticate user/pwd combinations
            // Note: this overrides the collection set in the group authentication (group auth is deprecated)
            
            if(dataObj["groupid"] != null)
            {
              session._AccountColl  = dataObj["groupid"].toLowerCase();
            }
            else
              session._AccountColl = "users";      

            //## MOd Jul2 2014 - Passwords now case sensitive
            
            session._User        = dataObj["user"].toLowerCase();
            session._Password    = dataObj["pwd"];
            
            _GSharedDB.access("TED").then(readyToAuthenticate, onError: onAccessError);

            break;


          default:
            if(GDAuthProtocol) print("Unrecognised Authentication Protocol Packet: ${workUnit.workData}");

            session.Send('{"result":"fail", "Description":"Authentication Request Denied"}\x00');
            break;
        }
      }
      catch(err)
      {
        if(GDAuthProtocol) print("Error in Protocol: $err");

        session.Send('{"result":"fail", "Description":"Authentication Request Denied"}\x00');
      }
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
   *  This will query the "bootloaders" collection for the "default" boot loader
   *
   *  Resulting in a document of the form:
   *
   *  { "name":"Group-ID Protocol",                                       // Description - unused
   *    "accountMode":"remote",                                           // CSessionManager - unused
   *    "accountSrc":"DB_AUTHENTICATE",                                   // unused
   *    "ui":"loginTED",                                                  // CSessionManager currentState
   *    "protocol":"SESSION_AUTH_GROUPID",                                // CSessionManager _sessionState FSM-state
   *    "command":"GET_GROUP_ID",                                         // CSessionManager FSM-state command
   *    "authState":"loginC",                                             // CAuthenticationManager currentState
   *    "authProtocol":"TYPE1_GROUPID_START",                             // CAuthenticationManager protocolState
   *    "notes":"This boot loader Path uses the GroupID login protocol",
   *    "default":true }
  */
  readyToQueryBootLoader(result)
  {
    DbCollection coll;

    if(GDAuthProtocol) print("readyToQuery:");

    coll = _GSharedDB.collection("bootloaders");

    coll.findOne(where.eq("default",true)).then(onQuery, onError: onQueryError );
  }

  //
  onQuery(result)
  {
    if(GDAuthProtocol) print(result.runtimeType);
    if(GDAuthProtocol) print("record: $result");

    try
    {
      // now add the loader to the response packet

      if(result != null)
      {
        _reply = result;

        _reply["type"]   = "query";
        _reply["result"] = "success";

        // If the loader is flash domain it has all 4 - _library _module _speller _xface
        // They need to be queried and added to the response packet

        session.Send(JSON.encode(_reply, toEncodable:marshallObject) + '\x00');
      }
      else
      {
        session.Send('{"type":"query", "result":"fail", "Description":"record not found"}\x00');
      }

    }
    catch(err)
    {
      if(GDAuthProtocol) print("boot loader encoding invalid: + $err");

      session.Send('{"type":"query", "result":"fail", "Description":"bootloader encoding invalid"}\x00');
    }
  }

  //
  onQueryError(err)
  {
    if(GDAuthProtocol) print("boot loader encoding invalid: + $err");

    session.Send('{"type":"query", "result":"fail", "Description":"bootloader encoding invalid"}\x00');
  }


  /**
   *   This will query the "auth_groups" collection for a matching GroupID
   *
   *   Resulting in a group document of the form:
   *
   *   {
   *      "_id":"ASVR",                                       // The unique group ID -
   *      "groupColl":"study.groups"                          // The collection holding the group document
   *      "project":"TED2",                                   // Description - unused
   *      "name":"TED Fall 2013",                             // Description - unused
   *      "loaderDomain":"TutorLoader.1.0",                   // ID used to define most of the rest of these
   *      "ui":"loginTED",                                    // CSessionManager currentState -
   *      "protocol":"SESSION_AUTH_STUDY"  ,                  // CSessionManager _sessionState
   *      "authColl":"Study.ASVR",                            // Collection holding the users for this group
   *      "dataColl":"Study.ASVR.Data",                       // Collection holding all data for study
   *      "authCommand":"GET_USER_PWD",                       // CSessionManager FSM-Command
   *      "authState":"loginD",                               // CAuthenticationManager currentState
   *      "authProtocol":"TYPE1_USERID_START",                // CAuthenticationManager protocolState
   *      "runtimeProtocol":"TEDLOG.1.0",                     // Requested serverside protocol - unused
   *      "notes":""
   *      },
   */
  readyToQueryGroupID_TYPE1(result)
  {
    DbCollection coll;

    if(GDAuthProtocol) print("readyToQuery:");

    coll = _GSharedDB.collection("auth_groups");

    coll.findOne(where.eq("_id",session._Password)).then(onGroupID, onError: onGroupIDError );
  }


  //
  onGroupID(result)
  {
    // record the StudyGroup and authCollection for the group before proceeding.
    // This is maintained internally to limit the attack surface of the server
    // Then process the result as a normal query

    // NOTE: Separate group authentication is deprecated in new public interface - Jul 2014
    
    if(result != null)
    {
      session._StudyGroup  = result["_id"];
      session._AccountColl = result["authColl"];
      session._DataColl    = result["dataColl"];
    }
    onQuery(result);
  }


  //
  onGroupIDError(err)
  {
    if(GDAuthProtocol) print("GroupID query invalid: + $err");

    session.Send('{"type":"query", "result":"fail", "Description":"Group Query Encoding invalid"}\x00');
  }


  /**
   *   This will query the Study Specific collection for a matching Student Profile
   *
   *    This is how a classList (user profile) document is structured
   *
   *    {
   *      "_id":ObjectID
   *      "userId":"jamesfr",
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
   *    Note that user profiles are only locally unique within the study group (classList) collection - They are
   *    globally unique under the study namespace
   *
   */
  studyAuthenticate(result)
  {
    DbCollection coll;

    if(GDAuthProtocol) print("ready To Authenticate Study: collection - ${session._AccountColl} - account - ${session._User}" );

    coll = _GSharedDB.collection(session._AccountColl);

    coll.findOne(where.eq("userId",session._User).eq("isActive",true)).then(onStudyAuthenticate, onError: onStudyAuthenticationError );
  }

  onStudyAuthError(err)
  {
    if(GDAuthProtocol) print("Error on Study Authentication attempt:");

    session.Send('{"type":"authenticate", "result":"fail", "Description":"Study Authentication Request Denied"}\x00');
  }

  /**
   *
   */
  onStudyAuthenticate(result)
  {
    if(GDAuthProtocol) print(result.runtimeType);
    if(GDAuthProtocol) print("User Profile:" + "Authenticated: $result");

    // NOTE: we can get a NULL result if there is no match and no other errors.

    if(result != null)
    {
      try
      {
        // Switch to the requested protocol - all future traffic on this socket will be managed by this
        // protocol unless/until another PROTOCOL_SWITCH is requested.

        session.protocolID = _Prequest;

        if(GDAuthProtocol) print("Protocol Switched: $_Prequest");

        // Build a response packet - basic packet is the Profile object

        _reply = result;

        // Maintain an encoded copy of the profile we can pass between isolates quickly

        session.profile = JSON.encode(_reply, toEncodable:marshallObject);

        _reply["type"]        = "authenticate";
        _reply["result"]      = "success";
        _reply["sessionid"]   = session.guid.toString();
        _reply["Description"] = "Access Granted";

        session.Send(JSON.encode(_reply, toEncodable:marshallObject) + '\x00');
      }
      catch(err)
      {
        if(GDAuthProtocol) print("Profile  Authentication result encode failed");

        session.Send('{"type":"authenticate", "result":"fail", "Description":"Profile Authentication Request Failed"}\x00');
      }
    }
    else
    {
      session.Send('{"type":"authenticate", "result":"fail", "Description":"Profile Authentication Request Failed"}\x00');
    }
  }

  //
  onStudyAuthenticationError(err)
  {
    if(GDAuthProtocol) print("Error on Authentication attempt:");

    session.Send('{"type":"authenticate", "result":"fail", "Description":"Authentication Request Denied"}\x00');
  }





  /**
   *  This manages standard user/password authentication against the User Collection
   *
   *
   *
   */
  readyToAuthenticate(result)
  {
    DbCollection coll;

    if(GDAuthProtocol) print("readyToAuthenticate: ${session._User} - pwd: ${session._Password} - against: ${session._AccountColl}");

    coll = _GSharedDB.collection(session._AccountColl);

    // coll.findOne(where.eq("user",session._User).fields(["user","pwd","_feature","_loader","isActive"])).then(onAuthenticate, onError: onAuthenticationError );
    
    coll.findOne(where.eq("user",session._User).eq("isActive",true)).then(onAuthenticate, onError: onAuthenticationError );
  }

  onAuthenticate(result)
  {
    if(GDAuthProtocol) print(result.runtimeType);
    if(GDAuthProtocol) print("User:" + "Authenticated: $result");

    // NOTE: we can get a NULL result if there is no match and no other errors.

    try
    {
      if((result != null) && (result["isValidated"] == false))
      {
          session.Send('{"type":"authenticate", "result":"validate", "Description":"Account Validation Required"}\x00');
      }
      
      else if((result != null) && validatePassword(result))
      {
        try
        {
          // Switch to the requested protocol - all future traffic on this socket will be managed by this
          // protocol unless a PROTOCOL_SWITCH is requested.
  
          session.protocolID = _Prequest;
          session.loader     = result['_loader'];
  
          if(GDAuthProtocol) print("Protocol Switched: $_Prequest");
  
          // Build a response packet - basic packet is the account object
  
          _reply = {};
  
          _reply["type"]        = "authenticate";
          _reply["result"]      = "success";
          _reply["sessionid"]   = session.guid.toString();
          _reply["Description"] = "Access Granted";
  
          _reply['account']     = result;
  
          session.Send(JSON.encode(_reply, toEncodable:marshallObject) + '\x00');
        }
        catch(err)
        {
          if(GDAuthProtocol) print("Authentication result encode failed");
  
          session.Send('{"type":"authenticate", "result":"fail", "Description":"Authentication Request Denied"}\x00');
        }
      }
      else
      {
        session.Send('{"type":"authenticate", "result":"fail", "Description":"Authentication Request Denied"}\x00');
      }
    }
    catch(err)
    {
      session.Send('{"type":"authenticate", "result":"fail", "Description":"Authentication Request Failed"}\x00');
    }
    
  }

  /**
   */
  bool validatePassword(result) 
  {
    // Now we want to create a SHA256 digest of the salted user pwd hash found in EB3
    // _packet['document']["EB3"] is 64 character hexidecimal representation of the USR PWD digest.
    
    SHA256 encoder = new SHA256();
    
    if(GDAuthProtocol) print("testing PWD: ${session._Password}");
    if(GDAuthProtocol) print("testing SLT: ${result["EB2"]}");
            
    encoder.add(crypto_util.hextoBytes(session._Password));
    encoder.add(crypto_util.hextoBytes(result["EB2"]));
       
    List digestList  = encoder.close();
    
    return (CryptoUtils.bytesToHex(digestList) == result["EB3"]);
  }
  
  
  //
  onAuthenticationError(err)
  {
    if(GDAuthProtocol) print("Error on Authentication attempt:");

    session.Send('{"type":"authenticate", "result":"fail", "Description":"Authentication Request Denied"}\x00');
  }

  //
  onAccessError(err)
  {
    if(GDAuthProtocol) print("Error on Authentication attempt:");

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

}











