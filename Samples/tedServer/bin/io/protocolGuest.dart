//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Kevin Willows
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
//
//  See protocolAdmin.dart


part of tedServer;


class protocolGuest
{
  // Reset the response flags

  sessionStatus _session;

  Map    _packet;
  Cursor _cursor;
  bool   _emptyFind;

  String _source;
  String _command;
  String _database;


  // Limit the number of things a guest can do
  
  protocolGuest(workPacket workUnit)
  {
    // Reset the response flags

    _session = workUnit.session;

    _session.releaseIsolate = false;
    _session.hasReply       = false;

    if(GSTProtocol) print("packetProcessor: ${workUnit.workData}");

    // This packet type will occur when the server is used as a Flash XML Socket Server
    // This will not occur in a WebSocket environment. (the crossdomain.xml file is used instead)

    try
    {
      workUnit.workData = workUnit.workData.substring(0,workUnit.workData.length - 1);

      // unmarshall the command packet

      _packet  = JSON.decode(workUnit.workData, reviver:reviverFunc);

      if(GSTProtocol) print("Decoded Packet: $_packet");

      _source  = _packet["source"];
      _command = _packet["command"];

      if(_packet["database"] != null) _database = _packet["database"];
                                 else _database = "TED";

      if(GSTProtocol) print(_packet.runtimeType);

       _GSharedDB.access(_database).then(processRequest, onError: onOpenError);
    }
    catch(err)
    {
      print("protocolGuest: Error in Protocol: $err");

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

    if(GSTProtocol) print("readyToProcess:");

    switch(_packet['command'])
    {
      case "sendmail":
        
        if(GSTProtocol) print("sendMail Requested: ${_packet['message']}");
        
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
           ..recipients.add('klahrlab@gmail.com')
           ..subject = _packet['subject']           
           ..text = _packet['message'];
          
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
        
        
      case "sendreminder":
        DbCollection coll;

        try
        {
          if(GSTProtocol) print("Query for Password Reminder: - ${_packet['userid']}");
  
          coll = _GSharedDB.collection("teachers");
  
          coll.findOne(where.eq("_id",_packet['userid']).eq("isActive",true)).then(onSendReminder, onError: onSendReminderError );
        }
        catch(err)
        {
          findError(err);
        }
        break;
        
        
      case "sendvalidation":
        DbCollection coll;

        try
        {
          if(GSTProtocol) print("Query to validate Account: - ${_packet['userid']}");
  
          coll = _GSharedDB.collection("teachers");
  
          coll.findOne(where.eq("_id",_packet['userid']).eq("isActive",true)).then(onSendValidation, onError: onSendValidationError );
        }
        catch(err)
        {
          findError(err);
        }        
        break;
        
        
      case "validateacct":
        DbCollection coll;

        try
        {
          if(GSTProtocol) print("Ready to validate Account: - ${_packet['userid']}");
  
          coll = _GSharedDB.collection("teachers");
  
          coll.update(where.eq("_id",_packet['userid']).eq("isActive",true).eq("validationCode",_packet['validationcode']), modify.set("isValidated",true)).then(onValidateSuccess, onError: onValidateError );
        }
        catch(err)
        {
          updateError(err);
        }        
        break;
        
      case "lockoutacct":
        DbCollection coll;

        try
        {
          if(GSTProtocol) print("Ready to lockout Account: - ${_packet['userid']}");
  
          coll = _GSharedDB.collection("teachers");
  
          coll.update(where.eq("_id",_packet['userid']).eq("isActive",true).eq("validationCode",_packet['validationcode']), modify.set("isLocked",true)).then(onLockoutSuccess, onError: onLockoutError );
        }
        catch(err)
        {
          updateError(err);
        }        
        break;
        
        
      // This creates a new teacher account        
      case "createacct":          
        
        try
        {         
          coll = _GSharedDB.collection(_packet['collection']);

          // saltHex is 64 character hexidecimal representation of the (hopefully CSRNG?) Salt
          
          String saltHex = crypto_util.createSalt();   
                    
          // Now we want to create a SHA256 digest of the salted user pwd hash found in EB3
          // _packet['document']["EB3"] is 64 character hexidecimal representation of the USR PWD digest.
          
          SHA256 encoder = new SHA256();

          if(GSTProtocol) print("SHA_PWD: ${ _packet['document']["EB3"]}");
          
          encoder.add(crypto_util.hextoBytes(_packet['document']["EB3"]));  // on entry EB3 is the SHA256 encoded pwd
          encoder.add(crypto_util.hextoBytes(saltHex));
             
          List digestList  = encoder.close();
          
          // Now we want to generate a SALT encoded copy of the RAW "keychr" encoded user pwd in EB4
          // Note: This cypher is reversible so we can send the user their password 
          //       We aren't saving nuclear secrets here so this is probably sufficient coding
          //
          // var keychr:String = "+ke*654%H13(9Ahf#3*nw(@n!lajL!J=";   see CTeacherNewAccount for encoding stage
          
          if(GSTProtocol) print("RAW_PWD: ${ _packet['document']["EB4"]}");
          
          List pcypherList = crypto_util.cypher(saltHex, _packet['document']["EB4"]);          
          
          _packet['document']["EB2"]  = saltHex;                               // Crypto SALT
          _packet['document']["EB3"]  = CryptoUtils.bytesToHex(digestList);    // Crypto SALTED HASH Digest
          _packet['document']["EB4"]  = CryptoUtils.bytesToHex(pcypherList);   // Crypto PWD
          
          if(GSTProtocol) print("SALT: ${ _packet['document']["EB2"]}");
          if(GSTProtocol) print("HASH: ${ _packet['document']["EB3"]}");
          if(GSTProtocol) print("CPWD: ${ _packet['document']["EB4"]}");
          
          _packet['document']["Created"]       = new DateTime.now().toUtc().toString();
          _packet['document']["Modified"]      = new DateTime.now().toUtc().toString();
          _packet['document']["isActive"]      = true;
          _packet['document']["isValidated"]   = false;    
          _packet['document']["isLocked"]      = false;    
          _packet['document']["validationCode"]= createValidationCode(32);           

          if(GSTProtocol) print("Ready to add user account: - $_packet");

          coll.insert(_packet['document']).then(insertSuccess, onError:insertError);
        }
        catch(err)
        {
          insertError(err);
        }
        break;
        
      default: 
        
         _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "document":"error"}\x00');                
        break;
    }
  }

  
  String createValidationCode(length)
  {
    String alphabet = 'ABCEDFGHIJKLMNOPQRSTUVWXYZ';    
    int ALPHA_SIZE  = alphabet.length -1; 
    String result   = '';
    int    i1;
    
    Random randGen = new Random(new DateTime.now().millisecondsSinceEpoch);
    
    for(i1 = 0 ; i1 < length ; i1++)
    {
      result += alphabet[randGen.nextInt(ALPHA_SIZE)];
    }
    
    return result;      
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
    if(GSTProtocol) print("sendMail Complete: $result");

    _session.Send('{"result":"OK", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
  }

  
  //
  sendMailError(result)
  {
    if(GSTProtocol) print("sendMail Failure: $result");

    _session.Send('{"result":"fail", "source":"$_source", "command":"$_command", "message":${encodeResult(result)}}\x00');
  }

  
  // Account creation success - send mail to initiate account validation.
  
  insertSuccess(result)
  {    
    try
    {
      _session.Send('{"result":"OK", "database":"$_database", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
    }
    catch(err)
    {
      sendMailError(err);
    }    
  }

  
  //
  insertError(result)
  {
    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }

  
  // Account creation success - send mail to initiate account validation.
  
  onSendValidation(result)
  {       
    if(GSTProtocol) print("onSendValidation: $result");

    try
    {
      // now add the loader to the response packet

      if(result != null)
      {
        // As long as the account is not locked, attempt to send the validation request
        
        if(result["isLocked"] == false)
        {
          var options = new GmailSmtpOptions()
              ..username = 'klahrlab@gmail.com'
              ..password = 'klahr#314159 '; // Password changed due to hack 'klahr123*ted';  
          
          // Create our email transport.
          var emailTransport = new SmtpTransport(options);
          
          var envelope = new Envelope()
           ..from = 'TED Tutor account confirmation <KlahrLab@gmail.com>'
           ..recipients.add(_packet["userid"])
           ..subject = "Email address validation"       
           ..text = '''Thank you for using the TED Tutor.

To complete your account creation, please confirm your email address by clicking this link:

http://go.tedtutor.org/#home=pubPortal;pubPortal=Account_Validate;user=${result["_id"]};validation=${result["validationCode"]}

By confirming your email address, you ensure that only you will receive emails from TED Tutor. This is important to protect the security and confidentiality of your information.

If you did not create an account to use the TED Tutor please click the following link to ensure that you will not receive emails in the future. We are sorry for any inconvenience.

http://go.tedtutor.org/#home=pubPortal;pubPortal=Account_Lockout;user=${result["_id"]};validation=${result["validationCode"]}

Thank you,
The TED Tutor Project.''';
          
            // Email it.
            emailTransport.send(envelope)
             .then(sendMailComplete)
             .catchError(sendMailError);
        }
        else
        {
          // If the account is locked send a psuedo success packet - but do not actually do anything
          
          sendMailComplete({"result":"OK", "source":"$_source", "command":"$_command", "document":"success"});
        }          
      }
      else
      {
        sendMailError({"result":"no_account"});
      }
    }
    catch(err)
    {
      sendMailError(err);      
    }
  }

  //
  onSendValidationError(result)
  {
    if(GSTProtocol) print("onSendValidationError: $result");
    
    _session.Send('{"result":"fail", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }

  
  // Account creation success - send mail to initiate account validation.
  
  onSendReminder(result)
  {       
    if(GSTProtocol) print("onSendReminder: $result");

    try
    {
      // now add the loader to the response packet

      if(result != null)
      {
        // As long as the account is not locked, attempt to send the validation request
        
        if(result["isLocked"] == false)
        {
          // extract the user password data and decode it        
          // Note: This cypher is reversible so we can send the user their password 
          //       We aren't saving nuclear secrets here so this is probably sufficient coding
          //
          // First remove the salt from the cyphered string  
          //  
          List pcypherList = crypto_util.cypher(result["EB2"], result["EB4"]);          

          String pwdRAW = CryptoUtils.bytesToHex(pcypherList);
          
          // Then remove the key from the string leave only the pwd part
          // i.e. where pwdRAW != keyHex
          
          List pList    = crypto_util.decypher(pwdRAW);  
          String pwdClr = crypto_util.bytestoString(pList);
          
          var options = new GmailSmtpOptions()
              ..username = 'klahrlab@gmail.com'
              ..password = 'klahr#314159 '; // Password changed due to hack 'klahr123*ted'; 
          
          // Create our email transport.
          var emailTransport = new SmtpTransport(options);
          
          var envelope = new Envelope()
           ..from = 'TED Tutor <KlahrLab@gmail.com>'
           ..recipients.add(_packet["userid"])
           ..subject = "TED Tutor account password"       
           ..text = '''Thank you for using the TED Tutor.

The password to access your TED Tutor account is: $pwdClr

The TED Tutor Project.''';
          
            // Email it.
            emailTransport.send(envelope)
             .then(sendMailComplete)
             .catchError(sendMailError);
        }
        else
        {
          // If the account is locked send a psuedo success packet - but do not actually do anything
          
          sendMailComplete({"result":"OK", "source":"$_source", "command":"$_command", "document":"success"});
        }          
      }
      else
      {
        sendMailError({"result":"no_account"});
      }
    }
    catch(err)
    {
      sendMailError(err);      
    }
  }

  //
  onSendReminderError(result)
  {
    if(GSTProtocol) print("onSendValidationError: $result");
    
    _session.Send('{"result":"fail", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }

  
  // Account creation success - send mail to initiate account validation.
  
  onValidateSuccess(result)
  {    
    try
    {
      _session.Send('{"result":"OK", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
    }
    catch(err)
    {
      sendMailError(err);
    }    
  }

  
  //
  onValidateError(result)
  {
    _session.Send('{"result":"fail", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }

  
  // Account creation success - send mail to initiate account validation.
  
  onLockoutSuccess(result)
  {    
    try
    {
      _session.Send('{"result":"OK", "source":"$_source", "command":"$_command", "document":${encodeResult(result)}}\x00');
    }
    catch(err)
    {
      sendMailError(err);
    }    
  }

  
  //
  onLockoutError(result)
  {
    _session.Send('{"result":"fail", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
  }

  
  //
  onOpenError(err)
  {
    if(GSTProtocol) print("Error on Authentication attempt:");

    _session.Send('{"result":"fail", "source":"unknown", "command":"db_open", "Description":"error accessing database"}\x00');
  }

  
  //
  findError(result)
  {
    if(GSTProtocol) print("Find Failure: $result");

    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "message":${encodeResult(result)}}\x00');
  }


  //
  updateError(result)
  {
    if(GSTProtocol) print("update Failed: $result");
    
    _session.Send('{"result":"fail", "database":"$_database", "source":"$_source", "command":"$_command", "document":"error", "message":${encodeResult(result)}}\x00');
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











