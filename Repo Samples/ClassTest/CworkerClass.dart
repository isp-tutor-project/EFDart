

class CworkerClass {
 
  CtestClass testObj;
  Dynamic     strValue;
  
  CworkerClass ()
  {
    
    testObj = new CtestClass();
    
    testObj['myValue']="testStringValue";
    
    strValue = testObj['myValue'];
    
    print(strValue);    
    
    testObj["doSomething"]("THis is a test");    
    
  }

  
}
