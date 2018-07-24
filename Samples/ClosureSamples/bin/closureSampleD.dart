


var global = 0;
var f, g, h;

// In this implementation f,g,h all have different instances of x
// pass by value

foo()
{
  var x = 0;

  f = () {
      global++;
      print('global value: ' + global.toString());

      return ++x;
    };

  g = () {
      global++;
      print('global value: ' + global.toString());

      return --x;
    };

  x++;

  h = extern(x);

//  x = 1;

  global++;
  print('global value: ' + global.toString());

  print(' local call to f(): ' + f().toString()); // "2"

//  x = 4;
}


Function extern(int x)
{
  return ()
      {
        global++;
        print('global value: ' + global.toString());

        print('h predec Value:' + x.toString());

        return --x;
      };
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