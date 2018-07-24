
#import('dart:mirrors');  
#import('dart:html');

#source('CtestClass.dart');
#source('CworkerClass.dart');

CtestClass    tClass;
CworkerClass  wClass;

void main() {

  Object strValue;
  
  wClass = new CworkerClass();
  
  tClass = new CtestClass();
  
  tClass['myValue']="testStringValue";
  
  strValue = tClass['myValue'];

  print(strValue);
  
  tClass["doSomething"]("THis is a test");

 // tClass["doSomethingElse"](tClass.myValue, "THis is a test");
  
  print(tClass.myValue);
  
  query("#text").text = "Click me!";

}
