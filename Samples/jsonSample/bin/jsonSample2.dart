
library jsonSample;

import 'dart:convert';


void main()
{
  
  var nobleGases = {
                    2  : 'helium',
                    10 : 'neon',
                    18 : 'argon',
                      };
  
  var nobleGases2 = {'array':
                    [{2  : 'helium'},
                    {10 : 'neon'},
                    {18 : 'argon'}]
                      };
  
  print(nobleGases2['array'][1]);

  var iterator = nobleGases2['array'][0].keys;
  
  for(var key in iterator)
  {
    print(key.runtimeType);
  }
  
  var decoded2 = JSON.decode('''{"array":
                                 [{"2"  : "helium"},
                                  {"10" : "neon"},
                                  {"18" : "argon"}]
                                    }''');
      
  print(decoded2['array'][1]);
  
  
  var iterator2 = decoded2['array'][0].keys;
  
  for(var key in iterator2)
  {
    print(key.runtimeType);
  }
  
  
  
  var decoded = JSON.decode('''{"_id":"jamesfr",
                                "firstname":"fred",
                                "mi":"d", 
                                "lastname":"james",
                                "ability":"low",
                                "study":"TED2_11_13",
                                 "phases":
                                         {
                                           "1":{"_phase":"phase1", "_loader":"loader1", "_features":"featuresA", "progress":"Ready",    "stateData":{"obj":"data"}},
                                           "2":{"_phase":"phase2", "_loader":"loader2", "_features":"featuresB", "progress":"Complete", "stateData":{"obj":"data"}}
                                         }
                                  }''');

  print(decoded);
  print(decoded.runtimeType);

  print(decoded['phases']['1']['_phase']);

  int num = 1;
  
  for(var i1 = 0 ; i1 < decoded['phases'].length ; i1++)
  {
    print(decoded['phases'][num.toString()]['_phase']);
    
    num++;
  }
  
  
  var numb = '1';
  
  if(decoded['phases'][numb]['progress'] == "Ready")
  {
    print("we're Ready to go");
  }
  
}

