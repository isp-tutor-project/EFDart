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

library crypto;

import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fixnum/fixnum.dart';

void main() {
 
  pwdGenerator();
  
  //codecTest();
  //decoderTest();
  
}
  
void pwdGenerator()
{
  SHA256 encoderRAW       = new SHA256();
  SHA256 encoder          = new SHA256();
  String keychr           = "+ke*654%H13(9Ahf#3*nw(@n!lajL!J=";  // same key used in TED flex framework 
  String GUESTpw          = "GUEST";
  String TEDROOTpw        = "klahr123*ted";
  String Hustonpw         = "Huston#2014Middle";
  String randUser         = "*^kjs2r9q3INF~!!)(*!@#&#165-= 12";
  String GUEST_CYPHER_HEX = '6c3e207962353425483133283941686623332a6e7728406e216c616a4c214a3d';
  String KLAHR_CYPHER_HEX = '40070442440406166245564c3941686623332a6e7728406e216c616a4c214a3d';
  String pwdToEncode;
  String pwdHex;
    
  String keyHex  = CryptoUtils.bytesToHex(keychr.runes.toList());  
  String saltHex = createSalt();                // This is the EB2 field in the database
  List   salt    = hextoBytes(saltHex); 

//  pwdToEncode = GUESTpw;  
//  pwdToEncode = TEDROOTpw;
  pwdToEncode = Hustonpw;
//  pwdToEncode = randUser;

  // SHA Encode the ClearText Password - This is the RAW password sent from the client 
  
  encoderRAW.add(pwdToEncode.runes.toList());
  pwdHex = CryptoUtils.bytesToHex(encoderRAW.close());

  print('SHA_PWD : $pwdHex');
  
  print('EB2(salt): $saltHex');    
   
  // Then we SHA encode the Salted version of the RAW pwd - this is the DB user password field EB3
  
  encoder.add(hextoBytes(pwdHex));
  encoder.add(salt);  
  List hash = encoder.close();
  
  print('EB3(HPWD): ${CryptoUtils.bytesToHex(hash)}');  
  
  // Then we take the user cleartext user password and encypher it with keychr - This is what is 
  // sent by the client when the account is created.
  //
  pwdHex           = CryptoUtils.bytesToHex(pwdToEncode.runes.toList());
  String cypherHex = CryptoUtils.bytesToHex(encypher(keyHex, pwdHex));
  
  // Then we encypher this with EB2 to store in the DB as EB4
  // 
  
  cypherHex = CryptoUtils.bytesToHex(encypher(saltHex, cypherHex));
  
  print('EB4(EPWD): $cypherHex');
    
  // undo the EB2 cypher
  
  String deCypherHex = CryptoUtils.bytesToHex(encypher(saltHex, cypherHex));
  
  print('RAW_CYPHER_HEX : $deCypherHex');
  
  // Then decypher the keychr cypher - yielding the user password
  
  List pList = decypher(keyHex, deCypherHex);  
  String Pwd = bytestoString(pList);  
  
  print('ORIGINAL PWD   : $Pwd');
  print('ORIGINAL LEN   : ${Pwd.length}');
  
}

List encypher(String S1, String S2) 
{
   List result = new List();
  
   List S1List = hextoBytes(S1);
   List S2List = hextoBytes(S2);
   
   // It is assumed that S1 S2 have same length
  
   for(int i1=0 ; i1 < S1List.length ; i1++)
   {
     // Note: If the ^ operation is done as Int32 and thus affects results type
     if(i1 < S2List.length)     
       result.add(S1List[i1] ^ S2List[i1]);
     else
       result.add(S1List[i1]);
   }
   
   return result;
}

/**
 *  Remove the key from the pwd - we pack the pwd cypher with characters from the key
 *  so when decyphering we only need to process S2 elements that are different from S1
 */
List decypher(String S1, String S2) 
{
   List result = new List();
  
   List S1List = hextoBytes(S1);
   List S2List = hextoBytes(S2);
   
   for(int i1=0 ; i1 < S1List.length ; i1++)
   {
     if((S1List[i1] != S2List[i1]))
        result.add(S1List[i1] ^ S2List[i1]);
     else
        break;         
   }
   
   return result;
}


void codecTest() 
{
  SHA256 encoder  = new SHA256();
  SHA256 encoderB;
  String password = "31\ttestdata\r";

  print('HEX password: ${CryptoUtils.bytesToHex(password.runes.toList())}');    
  
  encoder.add(password.runes.toList());
  encoderB = encoder.newInstance();
  
  List hash = encoder.close();
    
  String saltHex = createSalt();    
  List   salt    = hextoBytes(saltHex); 

  print('HEX salt    : $saltHex');    
  
  encoderB.add(password.runes.toList());
  encoderB.add(salt);  
  List hashB = encoderB.close();
  
  print('SALT ${salt.length} : $salt');  
  print('HASH ${hash.length} : $hash');  
  print('SALTED HASH ${hashB.length} : $hashB');  
  
  String salt64;
  String hash64;
  String hashb64;
  
  print(salt64  = CryptoUtils.bytesToBase64(salt));  
  print(hash64  = CryptoUtils.bytesToBase64(hash));  
  print(hashb64 = CryptoUtils.bytesToBase64(hashB));
  
  print('SALT ${salt.length} : ${CryptoUtils.base64StringToBytes(salt64)}');  
  print('HASH ${hash.length} : ${CryptoUtils.base64StringToBytes(hash64)}');  
  print('SALTED HASH ${hashB.length} : ${CryptoUtils.base64StringToBytes(hashb64)}');
    
  print(salt64  = CryptoUtils.bytesToHex(salt));  
  print(hash64  = CryptoUtils.bytesToHex(hash));  
  print(hashb64 = CryptoUtils.bytesToHex(hashB));
  
  print('SALT ${salt.length} : ${hextoBytes(salt64)}');  
  print('HASH ${hash.length} : ${hextoBytes(hash64)}');  
  print('SALTED HASH ${hashB.length} : ${hextoBytes(hashb64)}');

  String pwdSample = "akjsngt3g24tmo3tn";
  String hexSample = CryptoUtils.bytesToHex(pwdSample.runes.toList()).toString(); 
  
  
  print('Plain Text  : $pwdSample');
  
  print('Hex Encoded : $hexSample');
  
  print('decoded Text: ${hextoString(hexSample)}');
  
}

String createSalt() 
{
  Random randomizer = new Random(new DateTime.now().millisecondsSinceEpoch);
  
  List salt = new List();  
  
  for(int i1 = 0 ; i1 < 32 ; i1++)
      salt.add(randomizer.nextInt(256));
  
  return CryptoUtils.bytesToHex(salt);    
}


/**
 * Note that salt here is being xor'd instead of concatenated
 */
String decoderTest()
{
  List<int> salted;
  List<int> desalted;
  List<int> decoded;
  String    keyhex;
  String    password = 'klahr123*tes34234';
  
  String salt   = '0043691c1a6abb16e0de0599c8d53f319388f25c3c9962386c4151082e454652';  
  String hash   = '40070442440406166245565b0a755a5517332a6e7728406e216c616a4c214a3d';
  String keychr = "+ke*654%H13(9Ahf#3*nw(@n!lajL!J=";

  print('SALT ${salt.length} : ${hextoBytes(salt)}');  
  print('HASH ${hash.length} : ${hextoBytes(hash)}');  
    
  salted = cypher(hextoBytes(salt), hextoBytes(hash));
  
  print('HASH   : ${CryptoUtils.bytesToHex(hextoBytes(hash))}');
  print('SALTED : ${CryptoUtils.bytesToHex(salted)}');

  desalted = cypher(hextoBytes(salt), salted);
  
  print('HASH     : $hash');
  print('DESALTED : ${CryptoUtils.bytesToHex(desalted)}');
  
  keyhex = CryptoUtils.bytesToHex(keychr.runes.toList());
  
  decoded = cypher(desalted, hextoBytes(keyhex));
  
  print('PWD     : $password');
  print('DECODED : ${hextoString(CryptoUtils.bytesToHex(decoded))}');  
//  print('DECODED : ${bytestoString(decoded)}');  
  
  return hextoString(CryptoUtils.bytesToHex(decoded));
}


List cypher(List S1, List S2) 
{
   List result = new List();
  
   // It is assumed that S1 S2 have same length
  
   for(int i1=0 ; i1 < S1.length ; i1++)
   {
     // Note: the ^ operation is done as Int32 and thus affects results type
     
     result.add(S1[i1] ^ S2[i1]);
   }
   
   return result;
}


List<int> hextoBytes(String bytes) 
{
  var result = new List();    
  
  while(bytes.length > 0) 
  {
//    String hexpattern = bytes.substring(0,2);
//    print('hexpattern: $hexpattern');
    
//    result.add(Int32.parseRadix(bytes.substring(0,2),16));
    result.add(int.parse(bytes.substring(0,2),radix:16));
    
    bytes = bytes.substring(2);
  }
  
  return result;
}

String hextoString(String bytes) 
{
  List codeunits  = new List();    
  Utf8Decoder decoder = new Utf8Decoder(); 
  
  while(bytes.length > 0) 
  {    
    codeunits.add(int.parse(bytes.substring(0,2),radix:16));
    
    bytes = bytes.substring(2);
  }
  
  return decoder.convert(codeunits);
}


String bytestoString(List<int> codeunits) 
{
  Utf8Decoder decoder = new Utf8Decoder(); 
  
  return decoder.convert(codeunits);
}


