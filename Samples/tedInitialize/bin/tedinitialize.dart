//  The MIT License (MIT)
//
//  Copyright (c) 2013 Kevin Willows
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import 'package:mongo_dart/mongo_dart.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io';

Stopwatch      _taskTimer;

main()
{
  setStartTime();

  Db db = new Db('mongodb://127.0.0.1/TED');

  initializeDB()
  {

    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection bootloadercoll = db.collection('bootloaders');
    bootloadercoll.remove();

    List bootloaderList = [
                               {"name":"Group-ID Protocol",        "accountMode":"remote", "accountSrc":"DB_AUTHENTICATE", "ui":"loginTED", "protocol":"SESSION_AUTH_GROUPID", "command":"GET_GROUP_ID", "authState":"loginC", "authProtocol":"TYPE1_GROUPID_START", "notes":"This boot loader Path uses the GroupID login protocol",          "default":true },
                               {"name":"User | Password Protocol", "accountMode":"remote", "accountSrc":"DB_AUTHENTICATE", "ui":"loginTED", "protocol":"SESSION_AUTH_USERPWD", "command":"GET_USER_PWD", "authState":"loginA", "authProtocol":"TYPE0_USRPWD_START",  "notes":"This boot loader uses a standard Username Password combination", "default":false },
                             ];

    bootloaderList.forEach(initTimeStampFields);

    bootloadercoll.insertAll(bootloaderList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection groupcoll = db.collection('auth_groups');
    groupcoll.remove();

    List groupList = [
                      {"_id":"ADMIN",   "groupColl":"n/a",           "project":"none", "name":"Administrators",  "sessionui":"loginAdmin", "sessionprotocol":"SESSION_AUTH_USERPWD", "sessionCommand":"GET_USER_PWD", "authColl":"Users",       "dataColl":"n/a",              "authState":"loginA", "authProtocol":"TYPE1_USRPWD_START", "loaderProtocol":"FLEX_LOADER.1.0",  "protocolNext":"ADMIN.1.0",         "notes":"" },
                      {"_id":"ASVR",    "groupColl":"study.groups",  "project":"TED2", "name":"TED Fall 2013",   "sessionui":"loginTED",   "sessionprotocol":"SESSION_AUTH_STUDY"  , "sessionCommand":"GET_USER_ID",  "authColl":"Study.ASVR",  "dataColl":"Study.ASVR.Data",  "authState":"loginD", "authProtocol":"TYPE1_USERID_START", "loaderProtocol":"STUDY_LOADER.1.0", "protocolNext":"STUDY_LOGGER.1.0",  "notes":"" },
                      {"_id":"DEMO",    "groupColl":"n/a",           "project":"TED2", "name":"Demo (Guests)",   "sessionui":"tedDemo",    "sessionprotocol":"SESSION_DEMO"        , "sessionCommand":"n/a",          "authColl":"n/a",         "dataColl":"n/a",              "authState":"n/a",    "authProtocol":"n/a",                "loaderProtocol":"FLEX_LOADER.1.0",  "protocolNext":"AUTHENTICATE.1.0",  "notes":"" },
                      {"_id":"HISTORY", "groupColl":"n/a",           "project":"TED2", "name":"Demo (Guests)",   "sessionui":"tedDemo",    "sessionprotocol":"SESSION_DEMO"        , "sessionCommand":"n/a",          "authColl":"n/a",         "dataColl":"n/a",              "authState":"n/a",    "authProtocol":"n/a",                "loaderProtocol":"FLEX_LOADER.1.0",  "protocolNext":"AUTHENTICATE.1.0",  "notes":"" },
                   ];

    groupList.forEach(initTimeStampFields);

    groupcoll.insertAll(groupList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection studycoll = db.collection('studies');
    studycoll.remove();

    List studylist = [
                      {"_id":"TED2_11_13","project":"TED2", "name":"Fall 2013", "repository":"Tag/TED/Revision 544", "notes":"" },



                      ];

    studylist.forEach(initTimeStampFields);

    studycoll.insertAll(studylist);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection phasescoll = db.collection('TED2_11_13.phases');
    phasescoll.remove();

    List phaselist = [
                        {"_id":"PRETST",  "seqndx":1,   "name":"Pre-Test",    "_loader":"STORY_FALL13_RMT"},
                        {"_id":"TUTOR",   "seqndx":2,   "name":"Tutor",       "_loader":"TED2_FALL13B_RMT"},
                        {"_id":"PSTTST",  "seqndx":3,   "name":"Post-Test",   "_loader":"STORY_FALL13_RMT" },
                      ];

    phaselist.forEach(initTimeStampFields);

    phasescoll.insertAll(phaselist);

    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection condAcoll = db.collection('TED2_11_13.PRETST');
    condAcoll.remove();

    List  condAlist = [
                        {"_features":"PRETESTA","description":""},
                        {"_features":"PRETESTB","description":""},
                      ];

    condAlist.forEach(initTimeStampFields);

    condAcoll.insertAll( condAlist);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection condBcoll = db.collection('TED2_11_13.TUTOR');
    condBcoll.remove();

    List  condBlist = [
                        {"_features":"TED2HIGH",    "description":""},
                        {"_features":"TED2HIGH/DD", "description":""},
                        {"_features":"TED2LOW",     "description":""},
                        {"_features":"TED2LOW/DD",  "description":""}
                      ];

    condBlist.forEach(initTimeStampFields);

    condBcoll.insertAll( condBlist);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection condCcoll = db.collection('TED2_11_13.PSTTST');
    condCcoll.remove();

    List  condClist = [
                        {"_features":"POSTTESTA", "description":""},
                        {"_features":"POSTTESTB", "description":""},
                      ];

    condClist.forEach(initTimeStampFields);

    condCcoll.insertAll( condClist);



    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection classcoll = db.collection('study.groups');
    classcoll.remove();

    List classeslist = [
                        {"_id":"ASVR", "_study":"TED2_11_13", "year":"2013-14", "_school":"", "school_nn":"SciTech", "_teacher":"", "teacher_nn":"Dana", "grade":0, "subject":"Earth Science", "classid":"Period 2", "_classList":"Study.ASVR" },
                       ];

    classeslist.forEach(initTimeStampFields);

    classcoll.insertAll(classeslist);


    DbCollection classlistcoll = db.collection('Study.ASVR');
    classlistcoll.remove();

//    List classlist = [
//                        {"_id":ObjectID, "userId":"jamesfr", "firstname":"fred", "mi":"d", "lastname":"james", "ability":"low" },
//                     ];
//
//    classlist.forEach(initTimeStampFields);

//    classlistcoll.insertAll(classlist);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection locationcoll = db.collection('institutions');
    locationcoll.remove();

    List locationlist = [{"District":"Pittsburgh Public Schools", "Name":"Pittsburgh Science & Technology Academy", "Name_nn":"SciTech", "Classification":"Study Location",
                        "Address":{"Street":"107 Thackeray St", "City":"Pittsburgh", "State":"PA", "Country":"USA", "ZipCode":"15213"}, "_contact":"", "Contact_nn":"Dana","Notes":"Currently Empty"},

                        {"District":"Catholic Diocese of Pittsburgh", "Name":"Sister Thea Bowman Catholic Academy", "Name_nn":"St James", "Classification":"Study Location",
                          "Address":{"Street":"721 Rebecca Ave", "City":"Pittsburgh", "State":"PA", "Country":"USA", "ZipCode":"15221"}, "_contact":"", "Contact_nn":"Mary Beth","Notes":"Co-Principals - Sister Marie Margaret Wolf, S.C. and Mrs. Ednarita Canton"},
                      ];

    locationlist.forEach(initTimeStampFields);

    locationcoll.insertAll(locationlist);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************


    DbCollection coll = db.collection('users');
    coll.remove();

    List userListFutureStructure = [
                     {"year":"2013", "NN":"generic", "FN":"firstname", "LN":"lastname", "MI":"middleinitial", "GUID":"uniquemodifier", "_feature":"NONE",
                       "user":"username", "pwd": "passwordgroupid", "classIDs":[123,234], "StudyIDs":[232,255,011],
                       "Birth":1322516, "Address":{"street":"street address part", "city":"city name", "state/prov/region":"region", "country":"country", "postalcode":"15213"},
                       "_loader":"loaderName", "Roles":"UserRoles", "Phone":"412-513-9103", "Email":"kevinwillows@cmu.edu", "isActive":true, "Created":1322165, "Modified":1321652 },

                       {"year":"2013", "NN":"tedroot", "FN":"", "LN":"", "MI":"", "GUID":"", "_feature":"NONE",
                         "user":"tedroot", "pwd": "klahr123*ted", "classIDs":['Class1','Class2'], "StudyIDs":['Study1','Study2'],
                         "Address":{"street":"such and such", "city":"Pitt", "state/prov/region":"PA", "country":"USA", "postalcode":"15213"},
                         "_loader":"flexadmin", "Roles":"ADMIN", "Phone":"412-513-9103", "Email":"kevinwillows@cmu.edu", "isActive":true },
                     ];

    List userList = [
                      { "user":"tedroot",   "pwd":"klahr123*ted", "roles":"administrator", "_feature":"NONE", "_loader":"flexadmin", "isActive":true },

                      { "user":"demo",      "pwd":"guest", "roles":"tester", "_feature":"demo", "_loader":"demo", "isActive":true },
                      { "user":"prea",      "pwd":"guest", "roles":"tester", "_feature":"pretestA", "_loader":"ted_PP_LCL", "isActive":true },
                      { "user":"preb",      "pwd":"guest", "roles":"tester", "_feature":"pretestB", "_loader":"ted_PP_LCL", "isActive":true },

                      { "user":"psta",      "pwd":"guest", "roles":"tester", "_feature":"posttestA", "_loader":"ted_PP_LCL", "isActive":true },
                      { "user":"pstb",      "pwd":"guest", "roles":"tester", "_feature":"posttestB", "_loader":"ted_PP _LCL", "isActive":true },

                      { "user":"tedhigh",   "pwd":"guest", "roles":"tester", "_feature":"ted2high", "_loader":"ted2_LCL", "isActive":true },
                      { "user":"tedlow",    "pwd":"guest", "roles":"tester", "_feature":"ted2low",  "_loader":"ted2_LCL", "isActive":true },

                      { "user":"tedhighdd", "pwd":"guest", "roles":"tester", "_feature":"ted2highdd", "_loader":"ted2_LCL", "isActive":true },
                      { "user":"tedlowdd",  "pwd":"guest", "roles":"tester", "_feature":"ted2lowdd", "_loader":"ted2_LCL", "isActive":true },

                      { "user":"Guest",     "pwd":"guest", "roles":"tester", "_feature":"ted2lowdd", "_loader":"ted2_LCL", "isActive":true },
                      { "user":"TestMe",    "pwd":"guest", "roles":"tester", "_feature":"posttestA", "_loader":"ted_PP_LCL", "isActive":true },
                      { "user":"TestMe2",   "pwd":"guest", "roles":"tester", "_feature":"posttestB", "_loader":"ted_PP_LCL", "isActive":true },

                      { "user":"ted",       "pwd":"guest", "roles":"tester", "_feature":"ted2",    "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedINT",    "pwd":"guest", "roles":"tester", "_feature":"ted2int", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedSUM",    "pwd":"guest", "roles":"tester", "_feature":"ted2sum", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedPRE",    "pwd":"guest", "roles":"tester", "_feature":"ted2pre", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedPST",    "pwd":"guest", "roles":"tester", "_feature":"ted2pst", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedSBS",    "pwd":"guest", "roles":"tester", "_feature":"ted2sbs", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedR01",    "pwd":"guest", "roles":"tester", "_feature":"ted2r01", "_loader":"ted2_LCL_SKL", "isActive":true },

                      { "user":"tedDDA",    "pwd":"guest", "roles":"tester", "_feature":"ted2eicmba", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedDDB",    "pwd":"guest", "roles":"tester", "_feature":"ted2eicmbb", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedDDC",    "pwd":"guest", "roles":"tester", "_feature":"ted2eicmbc", "_loader":"ted2_LCL_SKL", "isActive":true },

                      { "user":"tedEIA",    "pwd":"guest", "roles":"tester", "_feature":"ted2eia", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedEIB",    "pwd":"guest", "roles":"tester", "_feature":"ted2eib", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedEIC",    "pwd":"guest", "roles":"tester", "_feature":"ted2eic", "_loader":"ted2_LCL_SKL", "isActive":true },

                      { "user":"tedSOLCAT", "pwd":"guest", "roles":"tester", "_feature":"tedSOLCAT", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedSOLCOM", "pwd":"guest", "roles":"tester", "_feature":"tedSOLCOM", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedSTACAT", "pwd":"guest", "roles":"tester", "_feature":"tedSTACAT", "_loader":"ted2_LCL_SKL", "isActive":true },
                      { "user":"tedSTACOM", "pwd":"guest", "roles":"tester", "_feature":"tedSTACOM", "_loader":"ted2_LCL_SKL", "isActive":true },
                    ];

    userList.forEach(initBirthDateField);
    userList.forEach(initTimeStampFields);

    coll.insertAll(userList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection loadercoll = db.collection('loaders');
    loadercoll.remove();

    List loaderList = [
                        { "_id":"flexadmin",            "domain":"flex", "_xface":"adminConsole" },
                        { "_id":"studyComplete",        "domain":"flex", "_xface":"studyComplete" },

                        { "_id":"TED2_FALL13B_LCL",     "domain":"flash", "appclass":"CWOZTutorDoc",  "scenespath":"ted2/", "scenesxml":"scenedescr.xml", "graphpath":"ted2/", "graphjson":"scenegraph.json", "anigraphjson":"sceneanimation.json", "_library":"std", "_module":"ted2", "_speller":"std", "_xface":"ted2_LCL" },
                        { "_id":"TED2_FALL13B_RMT",     "domain":"flash", "appclass":"CWOZTutorDoc",  "scenespath":"ted2/", "scenesxml":"scenedescr.xml", "graphpath":"ted2/", "graphjson":"scenegraph.json", "anigraphjson":"sceneanimation.json", "_library":"std", "_module":"ted2", "_speller":"std", "_xface":"ted2_RMT" },
                        { "_id":"TED2_FALL13B_LCL_SKL", "domain":"flash", "appclass":"CWOZTutorDoc",  "scenespath":"ted2/", "scenesxml":"scenedescr.xml", "graphpath":"ted2/", "graphjson":"scenegraph.json", "anigraphjson":"sceneanimation.json", "_library":"std", "_module":"ted2", "_speller":"std", "_xface":"ted2_LCL_SKL" },

                        { "_id":"STORY_FALL13_LCL",     "domain":"flash", "appclass":"CWOZTutorDoc",  "scenespath":"prepost/", "scenesxml":"scenedescr.xml", "graphpath":"prepost/", "graphjson":"scenegraph.json", "_library":"std", "_module":"prepost", "_speller":"std", "_xface":"ted_PP_LCL" },
                        { "_id":"STORY_FALL13_RMT",     "domain":"flash", "appclass":"CWOZTutorDoc",  "scenespath":"prepost/", "scenesxml":"scenedescr.xml", "graphpath":"prepost/", "graphjson":"scenegraph.json", "_library":"std", "_module":"prepost", "_speller":"std", "_xface":"ted_PP_RMT" }
                      ];

    loaderList.forEach(initTimeStampFields);

    loadercoll.insertAll(loaderList);



    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection librarycoll = db.collection('libraries');
    librarycoll.remove();

    List libraryList =  [
                         { "_id":"std", "path":"libs/", "libs":"tedcore.swf" }
                        ];

    libraryList.forEach(initTimeStampFields);

    librarycoll.insertAll(libraryList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection modulecoll = db.collection('modules');
    modulecoll.remove();

    List moduleList =  [
                        { "_id":"ted2", "path":"ted2/", "mods":"RampIntro_FLA.swf,StepByStep_FLA.swf,ExpInstr_FLA.swf,SolCatRem_FLA.swf,SolComRem_FLA.swf,StaCatRem_FLA.swf,StaComRem_FLA.swf"},
                        { "_id":"ted2int", "path":"ted2/", "mods":"RampIntro_FLA.swf"},
                        { "_id":"ted2pre", "path":"ted2/", "mods":"RampIntro_FLA.swf,StepByStep_FLA.swf,ExpInstr_FLA.swf,StaCatRem_FLA.swf,StaComRem_FLA.swf"},
                        { "_id":"ted2pst", "path":"ted2/", "mods":"RampIntro_FLA.swf"},
                        { "_id":"ted2sbs", "path":"ted2/", "mods":"StepByStep_FLA.swf,ExpInstr_FLA.swf,SolCatRem_FLA.swf,SolComRem_FLA.swf,StaCatRem_FLA.swf,StaComRem_FLA.swf"},

                        { "_id":"tedSOLCAT", "path":"ted2/", "mods":"SolCatRem_FLA.swf"},
                        { "_id":"tedSOLCOM", "path":"ted2/", "mods":"SolComRem_FLA.swf"},
                        { "_id":"tedSTACAT", "path":"ted2/", "mods":"StepByStep_FLA.swf,ExpInstr_FLA.swf,StaCatRem_FLA.swf,StaComRem_FLA.swf"},
                        { "_id":"tedSTACOM", "path":"ted2/", "mods":"StepByStep_FLA.swf,ExpInstr_FLA.swf,StaCatRem_FLA.swf,StaComRem_FLA.swf"},

                        { "_id":"ted2ei", "path":"ted2/", "mods":"ExpInstr_FLA.swf,RampIntro_FLA.swf"},

                        { "_id":"prepost", "path":"prepost/", "mods":"prepost_FLA.swf,dedreason_FLA.swf"  },
                      ];

    moduleList.forEach(initTimeStampFields);

    modulecoll.insertAll(moduleList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection spellercoll = db.collection('spellers');
    spellercoll.remove();

    List spellerList =  [
                         { "_id":"std", "path":"dictionaries/en_US/", "rules":"en_US.aff", "dict":"en_US.dic" }
                        ];

    spellerList.forEach(initTimeStampFields);

    spellercoll.insertAll(spellerList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection featurecoll = db.collection('features');
    featurecoll.remove();

    List featureList =  [
                           { "_id":"NONE",       "description":"none", "features":"" },

                           { "_id":"TED2HIGH",   "description":"High Reasoning | Free Response", "features":"DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"TED2LOW",    "description":"Low Reasoning  | Free Response", "features":"DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_LOWABILITY" },

                           { "_id":"TED2HIGH/DD", "description":"High Reasoning | Drop Down", "features":"DMO_ALL:FTR_CMB:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"TED2LOW/DD",  "description":"Low Reasoning  | Drop Down", "features":"DMO_ALL:FTR_CMB:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_LOWABILITY" },

                           { "_id":"ted2",       "description":"none", "features":"DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2int",    "description":"none", "features":"DMO_INT:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2sum",    "description":"none", "features":"DMO_SUM:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2pre",    "description":"none", "features":"DMO_PRE:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_LOWABILITY" },
                           { "_id":"ted2pst",    "description":"none", "features":"DMO_PST:FTR_RAMPSINTRO:FTR_RAMPSPOSTTEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2r01",    "description":"none", "features":"DMO_R01:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2sbs",    "description":"none", "features":"DMO_SBS:FTR_LOWABILITY:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },

                           { "_id":"ted2eicmba", "description":"none", "features":"DMO_CMBA:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_CMB:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2eicmbb", "description":"none", "features":"DMO_CMBB:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_CMB:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2eicmbc", "description":"none", "features":"DMO_CMBC:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_CMB:FTR_RAMPSPOSTTEST" },

                           { "_id":"ted2eia",    "description":"none", "features":"DMO_EIA:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2eib",    "description":"none", "features":"DMO_EIB:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },
                           { "_id":"ted2eic",    "description":"none", "features":"DMO_EIC:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST" },

                           { "_id":"tedSOLCAT",  "description":"none", "features":"DMO_SOLCAT:FTR_SOLCAT" },
                           { "_id":"tedSOLCOM",  "description":"none", "features":"DMO_SOLCOM:FTR_SOLCOM" },
                           { "_id":"tedSTACAT",  "description":"none", "features":"DMO_STACAT:FTR_STACAT" },
                           { "_id":"tedSTACOM",  "description":"none", "features":"DMO_STACOM:FTR_STACOM" },

                           { "_id":"PRETESTA",    "description":"Pre-Test Type A - Drinks etc",  "features":"FTR_PRETEST:FTR_TYPEA" },
                           { "_id":"PRETESTB",    "description":"Pre-Test Type B - Cookies etc", "features":"FTR_PRETEST:FTR_TYPEB" },

                           { "_id":"PRETESTA/a",  "description":"Pre-Test Type A - Drinks etc",  "features":"FTR_PRETEST:FTR_TYPEA:FTR_ASSESSA" },
                           { "_id":"PRETESTB/a",  "description":"Pre-Test Type B - Cookies etc", "features":"FTR_PRETEST:FTR_TYPEB:FTR_ASSESSB" },

                           { "_id":"POSTTESTA",   "description":"Post-Test Type A - Drinks etc", "features":"FTR_POSTTEST:FTR_TYPEA" },
                           { "_id":"POSTTESTB",   "description":"Post-Test Type B - Cookies etc", "features":"FTR_POSTTEST:FTR_TYPEB" },

                           { "_id":"POSTTESTA/a", "description":"Post-Test Type A w/Assessment - Drinks etc", "features":"FTR_POSTTEST:FTR_TYPEA:FTR_ASSESSA" },
                           { "_id":"POSTTESTB/a", "description":"Post-Test Type B w/Assessment - Cookies etc", "features":"FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB" },
                        ];

    featureList.forEach(initTimeStampFields);

    featurecoll.insertAll(featureList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************

    DbCollection interfacecoll = db.collection('interfaces');
    interfacecoll.remove();

    List interfaceList =  [
                           { "_id":"adminConsole",  "state":"adminConsole",  "log":"NONE" },
                           { "_id":"studyComplete", "state":"studyComplete", "log":"NONE" },

                           { "_id":"ted2_LCL",     "state":"tutorLoader", "demo":false, "debug":false, "log":"LOCAL",  "remote":false, "forcebackbutton":"false", "hpcheck":true, "sdcheck":true, "fscheck":true, "skillometer":false },

                           { "_id":"ted2_RMT",     "state":"tutorLoader", "demo":false, "debug":false, "log":"REMOTE", "remote":false, "forcebackbutton":"false", "hpcheck":true, "sdcheck":true, "fscheck":true, "skillometer":false },

                           { "_id":"ted2_LCL_SKL", "state":"tutorLoader", "demo":false, "debug":false, "log":"LOCAL",  "remote":false, "forcebackbutton":"false", "hpcheck":true, "sdcheck":true, "fscheck":true, "skillometer":false },

                           { "_id":"ted_PP_LCL",   "state":"tutorLoader", "demo":false, "debug":false, "log":"LOCAL", "remote":false, "forcebackbutton":"false", "hpcheck":false, "sdcheck":false, "fscheck":true, "skillometer":false },
                           { "_id":"ted_PP_RMT",   "state":"tutorLoader", "demo":false, "debug":false, "log":"REMOTE", "remote":false, "forcebackbutton":"false", "hpcheck":false, "sdcheck":false, "fscheck":true, "skillometer":false },
                        ];

    interfaceList.forEach(initTimeStampFields);

    interfacecoll.insertAll(interfaceList);


    //*****************************************************************************************************************************
    //*****************************************************************************************************************************


    print("Elapsed Time: ${getElapsedTime()}");

    stdout.close().then((result) => db.close());
  };

  
  String createValidationCode(length)
  {
    String alphabet = 'ABCEDFGHIJKLMNOPQRSTUVWXYZ';    
    int ALPHA_SIZE  = alphabet.length -1; 
    String result   = '';
    int    i1;
    
    Random randGen = new Random(new DateTime.now().millisecondsSinceEpoch);
    
    for(i1 = 0 ; i1 < length ; i1++)
    {
      result += alphabet[randGen.nextInt(ALPHA_SIZE)];
    }
    
    return result;      
  }

  
  testValidationOp()
  {
    
    DbCollection teacherColl = db.collection('teachers');

    teacherColl.update(where.eq("_id", "kevin@zipwiz.com"), modify.set("isValidated", true));
    
    print("User Validated?");
  }

  initializeTeachers() 
  {
        
    DbCollection teacherColl = db.collection('teachers');
    teacherColl.remove();
    
    List teacherList = [
                        { "_id" : "klahrlab@gmail.com", 
                    "firstname" : "Klahr", 
                     "lastname" : "Lab", 
                         "user" : "klahrlab@gmail.com", 
                          "pwd" : "klahr123*ted",       
                   "isValidated": true,
                      "isLocked": false,
                "validationCode": createValidationCode(32),   
                      "classes" : {"CMKW" : {"subject" : "Science", "grade" : "6", "period" : "3", "year" : "2014", "isActive" : true},
                                   "FFTC" : {"subject" : "Science", "grade" : "7", "period" : "6", "year" : "2014", "isActive" : true},
                                   "HZAW" : {"subject" : "Science", "grade" : "6", "period" : "2", "year" : "2014", "isActive" : true},
                                   "MGVJ" : {"subject" : "Science", "grade" : "7", "period" : "3", "year" : "2014", "isActive" : true},
                                   "OOSJ" : {"subject" : "Science", "grade" : "7", "period" : "8", "year" : "2014", "isActive" : true},
                                   "QFRS" : {"subject" : "Science", "grade" : "6", "period" : "8", "year" : "2014", "isActive" : true},
                                   "QNEI" : {"subject" : "Science", "grade" : "7", "period" : "6", "year" : "2014", "isActive" : true},
                                   "RFDZ" : {"subject" : "Science", "grade" : "6", "period" : "1", "year" : "2014", "isActive" : true},
                                   "RZUD" : {"subject" : "Science", "grade" : "6", "period" : "7", "year" : "2014", "isActive" : true},
                                   "TFYJ" : {"subject" : "Science", "grade" : "6", "period" : "3", "year" : "2014", "isActive" : true},
                                   "UMQT" : {"subject" : "Science", "grade" : "6", "period" : "6", "year" : "2014", "isActive" : true}}},
                                   
                         { "_id" : "sreddick@wiu.k12.pa.us", 
                     "firstname" : "Shaun", 
                      "lastname" : "Reddick", 
                          "user" : "sreddick@wiu.k12.pa.us", 
                           "pwd" : "huston#middle",
                    "isValidated": true,
                       "isLocked": false,
                 "validationCode": createValidationCode(32),   
                       "classes" : {"FFTC" : {"subject" : "Science", "grade" : "7", "period" : "6", "year" : "Huston 2014", "isActive" : true},
                                    "HZAW" : {"subject" : "Science", "grade" : "6", "period" : "2", "year" : "Huston 2014", "isActive" : true},
                                    "MGVJ" : {"subject" : "Science", "grade" : "7", "period" : "3", "year" : "Huston 2014", "isActive" : true},
                                    "OOSJ" : {"subject" : "Science", "grade" : "7", "period" : "8", "year" : "Huston 2014", "isActive" : true},
                                    "QFRS" : {"subject" : "Science", "grade" : "6", "period" : "8", "year" : "Huston 2014", "isActive" : true},
                                    "QNEI" : {"subject" : "Science", "grade" : "7", "period" : "6", "year" : "Huston 2014", "isActive" : true},
                                    "RFDZ" : {"subject" : "Science", "grade" : "6", "period" : "1", "year" : "Huston 2014", "isActive" : true},
                                    "RZUD" : {"subject" : "Science", "grade" : "6", "period" : "7", "year" : "Huston 2014", "isActive" : true},
                                    "TFYJ" : {"subject" : "Science", "grade" : "6", "period" : "3", "year" : "Huston 2014", "isActive" : true},
                                    "UMQT" : {"subject" : "Science", "grade" : "6", "period" : "6", "year" : "Huston 2014", "isActive" : true}}},
                                              
                        {"_id" : "kevin@zipwiz.com",
                   "firstname" : "Kevin",
                    "lastname" : "Willows",
                        "user" : "kevin@zipwiz.com",
                         "pwd" : "tester",
                  "isValidated": false,
                     "isLocked": false,
               "validationCode": createValidationCode(32),   
                     "classes" : {"ORV-BWB-RQL" : {"subject" : "Earth Science", "grade" : "8", "period" : "5", "year":"2014", "isActive" : true}}},
                                    
                        {"_id" : "kevinwillows@gmail.com",
                   "firstname" : "Kevin",
                    "lastname" : "Willows",
                        "user" : "kevinwillows@gmail.com",
                         "pwd" : "tester",
                  "isValidated": false,
                     "isLocked": false,
               "validationCode": createValidationCode(32),   
                     "classes" : {"ORV-BWB-RQL" : {"subject" : "Earth Science", "grade" : "8", "period" : "5", "year":"2014", "isActive" : true}}}                                  
                                    
                        ];
        
    teacherList.forEach(initTimeStampFields);

    teacherColl.insertAll(teacherList);

    print("Teacher Collection Initialized");
    
  }
  
  print("Un-comment line to initialize DB");

  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  
  // These functions will delete collections in the TED database and reinitialize them - use with care
  
  //db.open().then((c)=>initializeDB());
  db.open().then((c)=>initializeTeachers());
  //db.open().then((c)=>testValidationOp());
  
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@  
}

void sampleMap()
{
  Map result = new Map();
  
  try
  {
    print(result["isValidated"]);
    
    result["isValidated"] = false;    
    
    if((result != null) && (result["isValidated"] == false))
    {
      print("passed");
    }
  }
  catch(err)
  {
    print(err.toString()); 
  }  
  
}


void setStartTime()
{
  _taskTimer = new Stopwatch();
  _taskTimer.start();
}


int getElapsedTime()
{
  _taskTimer.stop();

  return _taskTimer.elapsedMilliseconds;
}


void initBirthDateField(var element)
{
  element["Birth"] = new DateTime(1960,12,27).toString();
}

void initTimeStampFields(var element)
{
  element["Created"]  = new DateTime.now().toUtc().toString();
  element["Modified"] = new DateTime.now().toUtc().toString();

  element["isActive"] = true;
}
