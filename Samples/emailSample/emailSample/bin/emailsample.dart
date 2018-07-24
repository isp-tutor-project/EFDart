
import 'dart:math';

import 'package:mailer/mailer.dart';

void main() 
{
  Map  _packet = new Map();
  
  var options = new GmailSmtpOptions()
      ..username = 'klahrlab@gmail.com'
      ..password = 'klahr123*ted'; 
  
  // Create our email transport.
  var emailTransport = new SmtpTransport(options);
  
  // Create our mail/envelope.
  
  _packet["userid"] = "kevinwillows@gmail.com";
  _packet["validationCode"] = createValidationCode(32);
  
  // !@!@!@!@ NOTE: there must be white space between the 'from' comment field and the <email@from.com>
  //               i.e. 'TED Tutor account confirmation<KlahrLab@gmail.com>' will truncate the word "confirmation"
  
  var envelope = new Envelope()
   ..from = 'TED Tutor account confirmation <KlahrLab@gmail.com>'
   ..recipients.add('klahrlab@gmail.com')
   ..subject = "Email address validation"
   
   //..attachments.add(new Attachment(file: new File('path/to/file')))
   //..text = _packet['message'];
  
   //..text = 'This \nis \nthe \nuser \nfeedback';
  
   ..text = '''Thank you for using the TED Tutor.

To complete your account creation, please confirm your email address by clicking this link:

http://www.tedtutor.org/#home=pubPortal;pubPortal=Account_Validation;user=${_packet["userid"]};validation=${_packet["validationCode"]}

By confirming your email address, you ensure that only you will receive emails from TED Tutor. This is important to protect the security and confidentiality of your information.

If you did not create an account to use the TED Tutor please click the following link to ensure that you will not receive emails in the future. We are sorry for any inconvenience.

http://www.tedtutor.org/#home=pubPortal;pubPortal=Account_Lockout;user=${_packet["userid"]};validation=${_packet["validationCode"]}

Thank you,
The TED Tutor Project.''';
  
   //..html = '<h1>Test</h1><p>Hey!</p>';
  
  // Email it.
  emailTransport.send(envelope)
   .then(sendMailComplete)
   .catchError(sendMailError);
  
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


//
sendMailComplete(result)
{
  print("sendMail Complete: $result");
}

//
sendMailError(result)
{
  print("sendMail Failure: $result");
}

