
library test;

import "dart:mirrors";

class TestClass {
  
  doStuff() => print("doStuff was called!");
}

main() {
  MirrorSystem ms = currentMirrorSystem();
  
  var mirrorSystem = currentMirrorSystem();
  var libraryMirror = mirrorSystem.findLibrary(const Symbol('test')).first;
  var classMirror = libraryMirror.classes[const Symbol('TestClass')];
  print(MirrorSystem.getName(classMirror.simpleName)); // 'StringBuffer'
  
  InstanceMirror im = classMirror.newInstance(const Symbol(''), []);
  
  var tc = im.reflectee;
  tc.doStuff();
  
}