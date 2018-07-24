
 
class CtestClass {

  var myValue;
  Map myMap;
  InstanceMirror fooIM;
  MethodMirror   MooIM;
  
  CtestClass ()
  {
    //lets get a reflection of foo   
    fooIM = reflect(this);   
    
    myMap = new Map();
    Date myDate = new Date.now();

    myMap['test'] = new Date.now();
    myMap['Date'] = myDate;

    assert(myMap['Date'].isUtc == myDate.isUtc);
    assert(myMap['Date'] is Date);
  }
  
  
  Dynamic operator call (String a, String b) {
    
  }

  Dynamic operator call(String a) {
    print(a);
  }
  
  void operator []= (String str, Object vat)  {

    //invoke the instance method  
    fooIM.setField(str, vat);  
  }

  Dynamic operator [] (String str)  {

    //invoke the instance method  
    //return new Future.immediate(fooIM.getField(str));  
    return fooIM.getField(str);
  }

  
  // See: http://phylotic.blogspot.com/2012/08/working-with-mirrors-in-dart-brief.html
//  MethodMirror operator [] (String str)  {
//           
//    MooIM = fooIM.type.methods[str];
//    
//    return MooIM;
//  }
  
  void doSomething(String message) {   
    print('doSomething method received message $message');   
  }   

  void doSomethingElse(int value, String message) {   
    print('doSomethingElse method received message $value $message');   
  }   

}
