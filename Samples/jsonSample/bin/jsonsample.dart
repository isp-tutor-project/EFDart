
library jsonSample;

import 'dart:convert';


void main()
{
  var encoded = JSON.encode([1, 2, { "a": null }]);

  print(encoded);
  print(encoded.runtimeType);

  var encoded2 = JSON.encode({"myArray":[1, 2, { "a": null }]});

  print(encoded2);
  print(encoded2.runtimeType);


  var decoded = JSON.decode('["foo", { "bar": 499 }]');

  print(decoded);
  print(decoded.runtimeType);

  var decoded2 = JSON.decode('{"MyObject":["foo", { "bar": 499 }]}');

  print(decoded2);
  print(decoded2.runtimeType);

  var decoded3 = JSON.decode('{"MyObject":"foo"}');

  print(decoded3);
  print(decoded3.runtimeType);

  var decoded4 = JSON.decode('[1,2,"test",4,5,6,7]');

  print(decoded4);
  print(decoded4.runtimeType);

  var decoded5 = JSON.decode('{"request_type":"DB_A","user":"Kevin","password":"klahr123*ted"}');

  print(decoded5["request_type"]);
  print(decoded5["user"].toLowerCase());
  print(decoded5["password"].toLowerCase());

  print(decoded5);
  print(decoded5.runtimeType);

}
