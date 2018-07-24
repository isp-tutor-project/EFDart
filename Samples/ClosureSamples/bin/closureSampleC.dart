


var scope = "globaScope";

Function checkScope()
{
  var scope="localScope";

  String f([String newValue=null])
  {
    if(newValue != null)
          scope = newValue;

    return(
        ()
        {
          print(scope);

          return scope;
        })();
  }

  return f;
}

main()
{
  print(checkScope);
  print(checkScope());

  Function F = checkScope();

  F();

  scope = "globalscope Updated";

  F("localScope Updated");

  print(checkScope());

  print(F());
}
