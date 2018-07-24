
library jsonSample;

import 'dart:convert';


void main()
{
  var profile = JSON.decode('''{"_id":"jamesfr",
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

  print(profile);
  print(profile.runtimeType);

  print(profile['phases']['1']['_phase']);

  int num = 1;

  for(var i1 = 0 ; i1 < profile['phases'].length ; i1++)
  {
    print(profile['phases'][num.toString()]['_phase']);

    num++;
  }

  for(var i1 = 0 , num=1 ; i1 < profile['phases'].length ; i1++)
  {
    print(profile['phases']['$num']['_phase']);

    num++;
  }


  var numb = '1';

  if(profile['phases'][numb]['progress'] == "Ready")
  {
    print("we're Ready to go");
  }

}

