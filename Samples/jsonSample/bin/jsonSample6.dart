
library jsonSample;

import 'dart:convert';


void main()
{
  Map profileBuild = new Map();

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

  print(profile['phases']['1']);

  profileBuild['1'] = profile['phases']['1'];

  print(profileBuild['1']);

}

