


var global = 0;
var f, g, h;

// in this implementation f,g,h all share the same object x
// pass by reference

foo()
{
  var x = new myObject(0);

  f = () {
      global++;
      print('global value: ' + global.toString());

      return ++x.val;
    };

  g = () {
      global++;
      print('global value: ' + global.toString());

      return --x.val;
    };

  x.val++;

  h = extern(x);

//  x.val = 1;

  global++;
  print('global value: ' + global.toString());

  print(' local call to f(): ' + f().toString()); // "2"

//  x = 4;
}


Function extern(myObject x)
{

  print('h allocated Value:' + x.val.toString());

  return ()
      {
        global++;
        print('global value: ' + global.toString());

        return --x.val;
      };
}

class myObject
{
  int val;

  myObject(this.val);
}


Function myFoo = foo;

main()
{
  myFoo();

  print('global call to g(): ' + g().toString()); // "1"
  print('global call to f(): ' + f().toString()); // "2"
  print('global call to h(): ' + h().toString()); // "2"

  myFoo();

  print('global call to g(): ' + g().toString()); // "1"
  print('global call to f(): ' + f().toString()); // "2"
  print('global call to h(): ' + h().toString()); // "2"

}




