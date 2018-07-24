
library jsonSample;

import 'dart:convert';

//{"source":"classlistview","command":"update","collection":"classList.ASVR","query":{"_id":"BitarAl"}, "document":{"$set":{"phases.1._loader":"STORY_FALL13_RMT","phases.1._phase":"PRETST","phases.1._features":"PRETESTA","phases.1.progress":"READY"}}}

void main()
{

  var decoded2 = JSON.decode('''
                              {"phases.1._loader":"STORY_FALL13_RMT","phases.1._phase":"PRETST","phases.1._features":"PRETESTA","phases.1.progress":"READY"}
                             ''');

  print(decoded2);
  print(decoded2.runtimeType);

  print(decoded2['phases.1._loader']);
  print(decoded2.runtimeType['phases']);

  print(decoded2['phases']['1']);
  print(decoded2.runtimeType['phases']['1']);

  print(decoded2['phases']['1']['_loader']);
  print(decoded2.runtimeType['phases']['1']['_loader']);


  var iterator2 = decoded2.keys;

  for(var key in iterator2)
  {
    print(key.runtimeType);
  }

}




