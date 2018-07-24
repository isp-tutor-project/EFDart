
class StringTest
{
  String str;

  StringTest(this.str);
}


void modString(String str)
{
  print(str);

  str += " + this is a test";

  print(str);
}


void modClassString(StringTest cstr)
{
  print(cstr.str);

  cstr.str += " + this is a test";

  print(cstr.str);
}


void main()
{
  String baseString = "rootString";
  StringTest ptrStr = new StringTest("rootClass");

  modString(baseString);

  print(baseString);

  print("---------------------------------");

  modClassString(ptrStr);

  print(ptrStr.str);



}
