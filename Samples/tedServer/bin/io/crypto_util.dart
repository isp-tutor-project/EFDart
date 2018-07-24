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


class crypto_util
{
  static String keychr = "+ke*654%H13(9Ahf#3*nw(@n!lajL!J=";

  
  static String createSalt() 
  {
    SHA256 encoder  = new SHA256();
      
    Random randomizer = new Random(new DateTime.now().millisecondsSinceEpoch);
    
    List salt = new List();  
    
    for(int i1 = 0 ; i1 < 32 ; i1++)
        salt.add(randomizer.nextInt(256));

    encoder.add(salt);  
    List hashB = encoder.close();
    
    return CryptoUtils.bytesToHex(hashB);    
  }
  
  /**
   *  Note that the S2 string is assumed to be padded to 32 Unicode points 64 hex digits 
   */
  static List cypher(String S1, String S2) 
  {
     List result = new List();
    
     List S1List = hextoBytes(S1);
     List S2List = hextoBytes(S2);
     
     // It is assumed that S1 S2 have same length
    
     for(int i1=0 ; i1 < S1List.length ; i1++)
     {
       // Note: If the ^ operation is done as Int32 and thus affects results type
       
       result.add(S1List[i1] ^ S2List[i1]);
     }
     
     return result;
  }

  /**
   *  Remove the key from the pwd - we pack the pwd cypher with characters from the key
   *  so when decyphering we only need to process S2 elements that are different from S1
   */
  static List decypher(String S2) 
  {
     List result = new List();
    
     String keychr = "+ke*654%H13(9Ahf#3*nw(@n!lajL!J=";    
     String S1     = CryptoUtils.bytesToHex(keychr.runes.toList());
     
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


  static List<int> hextoBytes(String bytes) 
  {
    var result = new List();    
    
    while(bytes.length > 0) 
    {
//    String hexpattern = bytes.substring(0,2);
//    print('hexpattern: $hexpattern');
      
      result.add(int.parse(bytes.substring(0,2),radix:16));
      
      bytes = bytes.substring(2);
    }
    
    return result;
  }

  
  static String hextoString(String bytes) 
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


  static String bytestoString(List<int> codeunits) 
  {
    Utf8Decoder decoder = new Utf8Decoder(); 
    
    return decoder.convert(codeunits);
  }
  
}