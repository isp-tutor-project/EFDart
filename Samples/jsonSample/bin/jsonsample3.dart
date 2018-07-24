
library jsonSample;

import 'dart:convert';


void main()
{
  
  var decoded2 = JSON.decode('''{
                                 "2"  : 1,
                                 "10" : 2.0,
                                 "18" : 3
                                    }''');
      
  print(decoded2["2"]);
  print(decoded2["2"].runtimeType);
  
  print(decoded2['10']);
  print(decoded2['10'].runtimeType);
  
  
  var iterator2 = decoded2.keys;
  
  for(var key in iterator2)
  {
    print(key.runtimeType);
  }
  
}

