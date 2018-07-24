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

Stopwatch      _taskTimer;

main()
{
  setStartTime();

  Db db = new Db('mongodb://127.0.0.1/TED');

  
  insertStudy()
  {
    DbCollection classCollection = db.collection('Study.CMKW');
    classCollection.remove();
    
    List classDataList = [
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Marie",
        "isActive" : true,
        "lastname" : "Curie",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q2CVS" : "SC",
                        "q3CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q4CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q2Bad" : "checked",
                        "q6CVS" : "CVS",
                        "q4Bad" : "checked",
                        "q2Good" : "unchecked",
                        "q6Good" : "unchecked",
                        "q6Bad" : "checked",
                        "q1CVS" : "CVS"
                    },
                    "ktSkills" : {
    
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE"
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "probAssess2" : "Swrong",
                        "probAssess4" : "Sright",
                        "probAssess1" : "Sright",
                        "probAssess7" : "Swrong",
                        "probAssess6" : "Swrong",
                        "probAssess3" : "Swrong",
                        "probAssess5" : "Swrong"
                    },
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "48"
                        },
                        "currNodeID" : "HIGH_STAKES"
                    },
                    "features" : "FTR_HSCC:NO_ITER",
                    "ktSkills" : {
    
                    }
                }
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "CurieMa"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Isaac",
        "isActive" : true,
        "lastname" : "Newton",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q6Good" : "checked",
                        "q4Good" : "unchecked",
                        "q6Bad" : "unchecked",
                        "q2Good" : "checked",
                        "q5CVS" : "MC",
                        "q4Bad" : "checked",
                        "q1CVS" : "SC",
                        "q2Bad" : "checked",
                        "q4CVS" : "MC",
                        "q2CVS" : "SC",
                        "q3CVS" : "MC"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "ktSkills" : {
    
                    }
                }
            },
            "2" : {
                "_features" : "ted2low",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "posttest2freeresp" : "because i want to find out if the type of ball matters so i made sure the ball was different and everything else is the same",
                        "SbS1kt_r0" : 0.37123248150066074,
                        "SbS3kt_r0" : 0.99815371385702,
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0kt_vvfar" : 0.9,
                        "pretest2setup" : "Top-Top,Fim-Fim,Bab-Lof,Steep-Steep",
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest3goal" : "SCIENCE",
                        "MAX_CSBS_R01" : 1,
                        "posttest2ramp" : "CVS",
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "posttest3setup" : "Top-Top,Fim-Fim,Bab-Bab,Steep-Not-Steep",
                        "pretest0kt_cvlog" : 0,
                        "pretest1goal" : "SCIENCE2",
                        "MAX_PSBS_R0" : 5,
                        "posttest1freeresp" : "only one thing is different",
                        "pretest2goal" : "ENGINEERING",
                        "posttest0ramp" : "CVS",
                        "SbS0kt_r0" : 0.999804124040252,
                        "pretest0ramp" : "MC",
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "pretest3kt_r0" : 0,
                        "pretest1se_text" : "To see what parts of the ramps mattered.",
                        "pretest2kt_cvlog" : 0,
                        "pretest3se_text" : "To compare everything about the ramps.",
                        "pretest1kt_vvfar" : 0.990602098298888,
                        "posttest1setup" : "Top-Top,Fim-Sif,Lof-Lof,Steep-Steep",
                        "pretest2kt_vvfar" : 0.990602098298888,
                        "pretest2se_text" : "To make the ball(s) roll farther / faster/ the same.",
                        "pretest0goal" : "SCIENCE2",
                        "pretest1kt_r2" : 0,
                        "pretest1kt_tov" : 0,
                        "pretest3ramp" : "MC",
                        "posttest1ramp" : "CVS",
                        "pretest0selfexp" : "PHRASE2",
                        "lastSBS" : "Q1",
                        "posttest3freeresp" : "because i want to find out if the slopes would matter if they are higher or lower so i changed the slopes and left everything else the same",
                        "pretest1tv_text" : "Surfaces, Balls",
                        "posttest2setup" : "Top-Top,Sif-Sif,Lof-Bab,Steep-Steep",
                        "SbS1kt_r2" : 0,
                        "pretest3setup" : "Middle-Top,Sif-Fim,Lof-Bab,Steep-Not-Steep",
                        "pretest2desired_outcome" : "Other Outcome",
                        "pretest1tv_sel" : "false",
                        "pretest3kt_r1" : 0.9962915738754334,
                        "pretest3kt_r2" : 0,
                        "SbS1kt_r1" : 0.9962915738754334,
                        "pretest1setup" : "Top-Top,Sif-Fim,Lof-Bab,Steep-Steep",
                        "pretest3kt_tov" : 0,
                        "SbS2kt_r2" : 0.3866758241758242,
                        "SbS0kt_r1" : 0.9999995215645684,
                        "pretest2kt_r0" : 0,
                        "MAX_CSBS_R2" : 2,
                        "pretest0setup" : "Top-Middle,Sif-Fim,Bab-Lof,Steep-Not-Steep",
                        "pretest2kt_r2" : 0,
                        "pretest3kt_vvfar" : 0.9991731195241144,
                        "pretest0se_text" : "To compare everything about the ramps.",
                        "SbS2kt_r1" : 0.9999578052717212,
                        "pretest2ramp" : "CVS",
                        "SbS3kt_r1" : 0.999995506882886,
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "SbS0kt_r2" : 0.9845843539644772,
                        "pretest0kt_tov" : 0,
                        "pretest0kt_r2" : 0,
                        "posttest3ramp" : "CVS",
                        "pretest1selfexp" : "PHRASE6",
                        "MAX_PSBS_R2" : 3,
                        "SbS3kt_r2" : 0.8686074031405745,
                        "posttest0freeresp" : "only one thing is different\r",
                        "pretest1kt_cvlog" : 0,
                        "pretest2kt_r1" : 0.9661764855363308,
                        "ftrfocuscorrect" : "true",
                        "MAX_PSBS_R1" : 3,
                        "SbS2kt_r0" : 0.982823718473085,
                        "pretest1kt_r1" : 0.9661764855363308,
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest3kt_cvlog" : 0,
                        "pretest2kt_tov" : 0,
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest1corrTYPE3" : "true",
                        "pretest1ramp" : "SC",
                        "pretest3selfexp" : "PHRASE2",
                        "pretest2selfexp" : "PHRASE10",
                        "pretest0kt_r0" : 0,
                        "pretest1kt_r0" : 0
                    },
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_LOWABILITY:R012_SEEN:MAX_PSBS_R0:PSBS_R1_LRN:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN",
                    "ktSkills" : {
                        "rule1" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "pT" : 0.041667,
                            "pL" : 0.9999995414995376
                        },
                        "rule2" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "pT" : 0.06,
                            "pL" : 0.999839644859978
                        },
                        "rule_vvfar" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "pT" : 0.213333,
                            "pL" : 0.9993495204166766
                        },
                        "rule_cvslog" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "pT" : 0.03,
                            "pL" : 0.03
                        },
                        "rule0" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "pT" : 0.046667,
                            "pL" : 0.9998132649836656
                        },
                        "rule_tov" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "pT" : 0.046667,
                            "pL" : 0.03
                        }
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER",
                    "globals" : {
                        "q2Bad" : "unchecked",
                        "q1CVS" : "MC",
                        "q2Good" : "checked",
                        "q6Good" : "unchecked",
                        "q6Bad" : "checked",
                        "q4Bad" : "checked",
                        "q4Good" : "unchecked",
                        "q3CVS" : "CVS",
                        "Correct_Assessments" : "2",
                        "q6CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "Correct_Designs" : "4",
                        "q4CVS" : "CVS"
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "NewtonIs"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Ada",
        "isActive" : true,
        "lastname" : "Lovelace",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q6CVS" : "CVS",
                        "q4Good" : "checked",
                        "q4Bad" : "unchecked",
                        "q1CVS" : "MC",
                        "q2Good" : "unchecked",
                        "q6Good" : "unchecked",
                        "q2CVS" : "SC",
                        "q2Bad" : "checked",
                        "q6Bad" : "checked",
                        "q5CVS" : "CVS",
                        "q3CVS" : "MC"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "ktSkills" : {
    
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "0"
                        }
                    }
                }
            },
            "2" : {
                "_features" : "ted2cmb",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "pretest3ramp" : "CVS",
                        "pretest3kt_r0" : 0.9263537784144659,
                        "posttest0freeresp" : "I designed my experiment the way I did because it said it wanted me to find out if the starting position of the ball would make a difference so I ONLY made the position of the balls different.",
                        "pretest0goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "posttest2setup" : "Middle-Middle,Sif-Sif,Bab-Lof,Steep-Steep",
                        "posttest1ramp" : "CVS",
                        "pretest3selfexp" : "PHRASE6",
                        "SbS3kt_r0" : 0.9916797026360296,
                        "pretest0se_text" : "To have only one part of the ramps different.",
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "posttest1freeresp" : "I did this because it asked if the surfaces would effect how far the ball rolledso I ONLY changed the surface of the ramp.",
                        "pretest2kt_tov" : 0.21774193548387097,
                        "pretest3kt_cvlog" : 0,
                        "pretest0selfexp" : "PHRASE1",
                        "posttest3ramp" : "CVS",
                        "lastSBS" : "Q4Q",
                        "pretest2desired_outcome" : "Same Outcome",
                        "posttest2freeresp" : "I did this because it asked if the type of ball would make a difference on how far the ball rolled so I ONLY changed the type of ball.",
                        "posttest2ramp" : "CVS",
                        "pretest1goal" : "SCIENCE2",
                        "posttest1setup" : "Top-Top,Sif-Fim,Lof-Lof,Not-Steep-Not-Steep",
                        "pretest3kt_r1" : 0.9661764855363307,
                        "pretest0ramp" : "CVS_WV",
                        "pretest2kt_r1" : 0.7499999999999999,
                        "pretest3corrTYPE1" : "true",
                        "pretest1selfexp" : "PHRASE3",
                        "pretest3corrTYPE2" : "true",
                        "pretest0kt_r1" : 0,
                        "pretest2kt_r0" : 0.5625,
                        "pretest0kt_r0" : 0,
                        "pretest1setup" : "Top-Top,Sif-Fim,Lof-Lof,Steep-Steep",
                        "pretest3kt_vvfar" : 0.9906020982988881,
                        "pretest0kt_tov" : 0,
                        "pretest1tv_text" : "Surfaces",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "posttest3freeresp" : "I did this because it asked if the height of the slop effects how far the ball rolls so I ONLY changed the slopes.",
                        "pretest0kt_cvlog" : 0,
                        "pretest0setup" : "Top-Top,Fim-Fim,Bab-Bab,Steep-Not-Steep",
                        "pretest1tv_sel" : "true",
                        "pretest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "posttest3setup" : "Middle-Middle,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "pretest2selfexp" : "PHRASE10",
                        "pretest2setup" : "Top-Top,Fim-Fim,Lof-Bab,Steep-Steep",
                        "pretest2kt_r2" : 0.32142857142857145,
                        "MAXVAL_CSBS_R2" : 1,
                        "MAX_PSBS_R0" : 1,
                        "pretest1se_text" : "To compare a part of the ramps.",
                        "pretest2goal" : "ENGINEERING",
                        "pretest1ramp" : "CVS",
                        "pretest1kt_r0" : 0.5625,
                        "pretest0kt_vvfar" : 0,
                        "pretest2kt_cvlog" : 0,
                        "SbS3kt_r2" : 0.32142857142857145,
                        "pretest1kt_r1" : 0.7499999999999999,
                        "pretest2ramp" : "CVS",
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest2se_text" : "To make the ball(s) roll farther / faster/ the same.",
                        "pretest3kt_r2" : 0.32142857142857145,
                        "pretest3se_text" : "To see what parts of the ramps mattered.",
                        "pretest1kt_r2" : 0.32142857142857145,
                        "ftrfocuscorrect" : "true",
                        "SbS3kt_r1" : 0.9962915738754334,
                        "pretest3goal" : "SCIENCE",
                        "pretest3tv_text" : "Slopes",
                        "pretest1kt_vvfar" : 0.9,
                        "pretest2kt_vvfar" : 0.9,
                        "pretest3tv_sel" : "true",
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "posttest0ramp" : "CVS",
                        "pretest1kt_tov" : 0.21774193548387097,
                        "pretest1corrTYPE1" : "true",
                        "pretest3kt_tov" : 0.7541999997703432,
                        "pretest0goal" : "SCIENCE",
                        "pretest1corrTYPE3" : "true",
                        "pretest0cvswvlogic" : "TYPEA",
                        "pretest1kt_cvlog" : 0,
                        "pretest0kt_r2" : 0.32142857142857145,
                        "pretest1corrTYPE2" : "true"
                    },
                    "ktSkills" : {
                        "rule_vvfar" : {
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9906020982988881,
                            "pL" : 0.9926069808624914
                        },
                        "rule_tov" : {
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.7541999997703432,
                            "pL" : 0.7656707483810606
                        },
                        "rule2" : {
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9222247621997512,
                            "pL" : 0.9268912764677661
                        },
                        "rule1" : {
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9962915738754334,
                            "pL" : 0.9964460928667658
                        },
                        "rule_cvslog" : {
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0,
                            "pL" : 0.03
                        },
                        "rule0" : {
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9916797026360296,
                            "pL" : 0.992067985953114
                        }
                    },
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "END_CLOAK"
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:R012_SEEN:PSBS_R0_LRN:EIA_SEEN:EIB_SEEN:EIC_SEEN"
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "features" : "FTR_POSTTEST:FTR_TYPEA:FTR_ASSESSA:NO_ITER",
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q3CVS" : "CVS",
                        "q6Bad" : "checked",
                        "Correct_Assessments" : "3",
                        "q4Good" : "unchecked",
                        "q2Bad" : "checked",
                        "Correct_Designs" : "6",
                        "q4Bad" : "checked",
                        "q4CVS" : "CVS",
                        "q6CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q2CVS" : "CVS",
                        "q2Good" : "unchecked",
                        "q5CVS" : "CVS",
                        "q1CVS" : "CVS"
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "2"
                        }
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "LovelaceAd"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Charles",
        "isActive" : true,
        "lastname" : "Darwin",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q2Bad" : "unchecked",
                        "q6Good" : "unchecked",
                        "q4Bad" : "unchecked",
                        "q4Good" : "checked",
                        "q5CVS" : "MC",
                        "q2Good" : "checked",
                        "q6Bad" : "checked",
                        "q6CVS" : "MC",
                        "q3CVS" : "MC",
                        "q1CVS" : "MC"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    }
                }
            },
            "2" : {
                "_features" : "ted2cmblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "pretest0selfexp" : "PHRASE9",
                        "pretest2kt_vvfar" : 0.9906020982988881,
                        "pretest2kt_tov" : 0.7541999997703432,
                        "pretest1se_text" : "To have only one part of the ramps different.",
                        "pretest1kt_tov" : 0.21774193548387097,
                        "pretest2kt_cvlog" : 0,
                        "pretest1kt_vvfar" : 0.9,
                        "pretest2ramp" : "CVS",
                        "pretest3kt_tov" : 0.9671133732576165,
                        "pretest1ramp" : "CVS",
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest3cvslogic" : "TYPEA",
                        "posttest3ramp" : "CVS",
                        "pretest3kt_vvfar" : 0.9991731195241145,
                        "pretest1selfexp" : "PHRASE1",
                        "pretest3kt_r1" : 0.9962915738754334,
                        "pretest3selfexp" : "PHRASE1",
                        "pretest0se_text" : "To make the balls do what I want.",
                        "pretest3kt_r2" : 0.9801970527952771,
                        "pretest2kt_r1" : 0.9661764855363307,
                        "pretest1kt_r0" : 0.5625,
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "pretest2kt_r2" : 0.8363269794721407,
                        "pretest2kt_r0" : 0.9263537784144659,
                        "posttest2freeresp" : "The ramps will test the distance of the ball by the brand.\r",
                        "pretest1kt_r1" : 0.7499999999999999,
                        "pretest2selfexp" : "PHRASE1",
                        "posttest1freeresp" : "I set the ramp up like this to test the surface of the ramp make a difference onhow far the ball rolls.",
                        "pretest2goal" : "ENGINEERING",
                        "posttest0freeresp" : "I set up the ramp like this to test how to starting position affects the distance of the ball.\r",
                        "pretest0kt_r0" : 0,
                        "posttest2ramp" : "CVS",
                        "pretest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "pretest3kt_cvlog" : 0,
                        "pretest2cvslogic" : "TYPEA",
                        "pretest0kt_r1" : 0,
                        "pretest1goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest1kt_r2" : 0.32142857142857145,
                        "pretest0desired_outcome" : "Maximize Outcome",
                        "pretest1goal" : "SCIENCE",
                        "pretest3goal" : "SCIENCE",
                        "pretest0setup" : "Top-Middle,Sif-Fim,Bab-Lof,Steep-Not-Steep",
                        "pretest0kt_vvfar" : 0,
                        "posttest1ramp" : "CVS",
                        "pretest0kt_r2" : 0,
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest2se_text" : "To have only one part of the ramps different.",
                        "pretest1cvslogic" : "TYPEA",
                        "pretest0ramp" : "MC",
                        "pretest0kt_tov" : 0,
                        "posttest1setup" : "Top-Top,Sif-Fim,Lof-Lof,Steep-Steep",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest0kt_cvlog" : 0,
                        "posttest0ramp" : "CVS",
                        "pretest3ramp" : "CVS",
                        "pretest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "ftrfocuscorrect" : "true",
                        "pretest0goal" : "SCIENCE2",
                        "pretest1kt_cvlog" : 0,
                        "pretest3kt_r0" : 0.9916797026360296,
                        "posttest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "pretest3se_text" : "To have only one part of the ramps different.",
                        "posttest3freeresp" : "The ramps are at a different slope so the ramps will test the slopes.",
                        "MAXVAL_CSBS_R2" : 1
                    },
                    "ktSkills" : {
                        "rule_cvslog" : {
                            "pS" : 0.1,
                            "Bel" : 0,
                            "pL" : 0.03,
                            "pT" : 0.03,
                            "pG" : 0.1
                        },
                        "rule0" : {
                            "pS" : 0.1,
                            "Bel" : 0.9916797026360296,
                            "pL" : 0.992067985953114,
                            "pT" : 0.046667,
                            "pG" : 0.1
                        },
                        "rule2" : {
                            "pS" : 0.1,
                            "Bel" : 0.9999770133484478,
                            "pL" : 0.999978392547541,
                            "pT" : 0.06,
                            "pG" : 0.1
                        },
                        "rule_vvfar" : {
                            "pS" : 0.1,
                            "Bel" : 0.9991731195241145,
                            "pL" : 0.9993495204166766,
                            "pT" : 0.213333,
                            "pG" : 0.1
                        },
                        "rule_tov" : {
                            "pS" : 0.1,
                            "Bel" : 0.9671133732576165,
                            "pL" : 0.9686480934678033,
                            "pT" : 0.046667,
                            "pG" : 0.1
                        },
                        "rule1" : {
                            "pS" : 0.1,
                            "Bel" : 0.9962915738754334,
                            "pL" : 0.9964460928667658,
                            "pT" : 0.041667,
                            "pG" : 0.1
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:EIA_SEEN:EIB_SEEN:EIC_SEEN",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "END_CLOAK"
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q2Good" : "unchecked",
                        "Correct_Designs" : "5",
                        "q4CVS" : "CVS",
                        "q2CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q6CVS" : "CVS",
                        "q3CVS" : "CVS",
                        "q6Bad" : "checked",
                        "q1CVS" : "MC",
                        "q4Bad" : "checked",
                        "q6Good" : "unchecked",
                        "Correct_Assessments" : "3",
                        "q2Bad" : "checked"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "DarwinCh"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Nikola",
        "isActive" : true,
        "lastname" : "Tesla",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q3CVS" : "MC",
                        "q2Bad" : "checked",
                        "q1CVS" : "MC",
                        "q6CVS" : "SC",
                        "q6Good" : "unchecked",
                        "q2Good" : "unchecked",
                        "q4Good" : "checked",
                        "q4Bad" : "unchecked",
                        "q2CVS" : "HOTAT",
                        "q6Bad" : "checked",
                        "q5CVS" : "SC"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2cmblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "ktSkills" : {
                        "rule2" : {
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999770133484478,
                            "pL" : 0.999978392547541
                        },
                        "rule_tov" : {
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9671133732576165,
                            "pL" : 0.9686480934678033
                        },
                        "rule1" : {
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999955068828859,
                            "pL" : 0.9999956940975967
                        },
                        "rule0" : {
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.999990032654244,
                            "pL" : 0.9999904978003684
                        },
                        "rule_cvslog" : {
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0,
                            "pL" : 0.03
                        },
                        "rule_vvfar" : {
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9991731195241145,
                            "pL" : 0.9993495204166766
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:PSBS_R2_LRN:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN",
                    "globals" : {
                        "pretest3kt_tov" : 0.9671133732576165,
                        "pretest0selfexp" : "PHRASE1",
                        "posttest2ramp" : "CVS",
                        "pretest1goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest0goal" : "ENGINEERING",
                        "pretest2se_text" : "To make the ball(s) roll farther / faster/ the same.",
                        "pretest3tv_sel" : "true",
                        "pretest3goal" : "SCIENCE",
                        "pretest3kt_r0" : 0.9916797026360296,
                        "SbS1kt_r0" : 0.9999059101496337,
                        "pretest1kt_r0" : 0.9263537784144659,
                        "pretest3kt_r1" : 0.9962915738754334,
                        "MAX_PSBS_R0" : 2,
                        "pretest3kt_r2" : 0.32142857142857145,
                        "pretest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest0cvslogic" : "TYPEA",
                        "pretest3selfexp" : "PHRASE3",
                        "pretest3kt_cvlog" : 0,
                        "pretest2kt_tov" : 0.7541999997703432,
                        "SbS2kt_r2" : 0.9978968932029776,
                        "pretest1kt_r1" : 0.9661764855363307,
                        "pretest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest3se_text" : "To compare a part of the ramps.",
                        "lastSBS" : "Q3",
                        "pretest1se_text" : "To compare a part of the ramps.",
                        "pretest0kt_r1" : 0.7499999999999999,
                        "SbS1kt_r2" : 0.9801970527952771,
                        "pretest0kt_r0" : 0.5625,
                        "pretest2setup" : "Top-Top,Sif-Sif,Lof-Bab,Steep-Steep",
                        "ftrfocuscorrect" : "true",
                        "pretest0kt_r2" : 0.32142857142857145,
                        "posttest3freeresp" : "I kept all factors the same except the slope, to find if the type of slope had anything to do with the landing.",
                        "pretest1kt_vvfar" : 0.9906020982988881,
                        "pretest0ramp" : "CVS",
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest1selfexp" : "PHRASE3",
                        "pretest0kt_vvfar" : 0.9,
                        "pretest1kt_tov" : 0.7541999997703432,
                        "posttest2freeresp" : "I kept all factors the same except the ball, to see if the types had anything to do with the different landings.",
                        "SbS2kt_r0" : 0.999990032654244,
                        "pretest1ramp" : "CVS",
                        "pretest2selfexp" : "PHRASE10",
                        "pretest1kt_cvlog" : 0,
                        "pretest2kt_cvlog" : 0,
                        "pretest3corrTYPE1" : "true",
                        "MAX_PSBS_R2" : 2,
                        "pretest0kt_cvlog" : 0,
                        "pretest1goal" : "SCIENCE",
                        "pretest0kt_tov" : 0.21774193548387097,
                        "pretest2goal" : "ENGINEERING",
                        "pretest1kt_r2" : 0.32142857142857145,
                        "MAX_CSBS_R2" : 2,
                        "posttest1freeresp" : "I kept my factors the same except the surface, to compare.",
                        "pretest1tv_text" : "Surfaces",
                        "posttest1ramp" : "CVS",
                        "MAX_CSBS_R01" : 1,
                        "pretest0goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "posttest3ramp" : "CVS",
                        "SbS2kt_r1" : 0.9999955068828859,
                        "pretest1tv_sel" : "true",
                        "pretest2kt_vvfar" : 0.9906020982988881,
                        "pretest2kt_r1" : 0.9661764855363307,
                        "pretest2ramp" : "CVS",
                        "pretest3tv_text" : "Slopes",
                        "pretest3ramp" : "CVS",
                        "pretest2kt_r0" : 0.9263537784144659,
                        "posttest1setup" : "Top-Top,Fim-Sif,Lof-Lof,Steep-Steep",
                        "pretest3setup" : "Middle-Middle,Sif-Sif,Bab-Bab,Not-Steep-Steep",
                        "SbS1kt_r1" : 0.9999578052717211,
                        "posttest3setup" : "Top-Top,Sif-Sif,Lof-Lof,Not-Steep-Steep",
                        "pretest1corrTYPE1" : "true",
                        "pretest1corrTYPE3" : "true",
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "SbS3kt_r2" : 0.8363269794721407,
                        "pretest0se_text" : "To have only one part of the ramps different.",
                        "posttest0ramp" : "CVS",
                        "SbS3kt_r1" : 0.9996038700437944,
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "pretest3corrTYPE2" : "true",
                        "pretest2desired_outcome" : "Other Outcome",
                        "MAX_PSBS_R1" : 2,
                        "SbS3kt_r0" : 0.9991124069722446,
                        "posttest0freeresp" : "Well, to only test the starting position, every other factor has to be the same.",
                        "pretest3kt_vvfar" : 0.9991731195241145,
                        "pretest2kt_r2" : 0.32142857142857145,
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest1corrTYPE2" : "true"
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    },
                    "globals" : {
                        "q4Bad" : "checked",
                        "Correct_Assessments" : "3",
                        "q6CVS" : "CVS",
                        "q6Bad" : "checked",
                        "q2Good" : "unchecked",
                        "q4Good" : "unchecked",
                        "q5CVS" : "CVS",
                        "q1CVS" : "CVS",
                        "q4CVS" : "CVS",
                        "q2CVS" : "CVS",
                        "Correct_Designs" : "6",
                        "q6Good" : "unchecked",
                        "q3CVS" : "CVS",
                        "q2Bad" : "checked"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER"
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "TeslaNi"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Jane",
        "isActive" : true,
        "lastname" : "Goodall",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q3CVS" : "MC",
                        "q4CVS" : "HOTAT",
                        "q4Good" : "unchecked",
                        "q2Bad" : "unchecked",
                        "q2Good" : "checked",
                        "q6Good" : "checked",
                        "q6Bad" : "unchecked",
                        "q1CVS" : "MC",
                        "q4Bad" : "checked",
                        "q5CVS" : "CVS_WV"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2cmbfblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "READY"
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "READY"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "GoodallJa"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Stephen",
        "isActive" : true,
        "lastname" : "Hawking",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "READY"
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "READY"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "HawkingSt"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Alan",
        "isActive" : true,
        "lastname" : "Turing",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q2Bad" : "unchecked",
                        "Correct_Designs" : "0",
                        "Correct_Assessments" : "0",
                        "q4Good" : "checked",
                        "q6Bad" : "unchecked",
                        "q6Good" : "checked",
                        "q4Bad" : "unchecked",
                        "q3CVS" : "MC",
                        "q5CVS" : "NC",
                        "q2Good" : "checked",
                        "q1CVS" : "SC"
                    },
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2low",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "SbS0kt_r0" : 0.9916797026360296,
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest1kt_vvfar" : 0.990602098298888,
                        "MAX_CSBS_R2" : 4,
                        "pretest0ramp" : "DC",
                        "pretest1ramp" : "SC",
                        "MAX_CSBS_R01" : 2,
                        "pretest2kt_tov" : 0,
                        "pretest1kt_cvlog" : 0,
                        "pretest1kt_r2" : 0,
                        "SbS0kt_r2" : 0.005813953488372094,
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest2ramp" : "CVS_WV",
                        "pretest0tv_sel" : "false",
                        "SbS3kt_r0" : 0.999999888162406,
                        "posttest3ramp" : "CVS",
                        "SbS3kt_r1" : 0.9999617787779648,
                        "pretest1kt_r1" : 0.7499999999999999,
                        "posttest2ramp" : "CVS",
                        "pretest3setup" : "Middle-Top,Sif-Fim,Bab-Lof,Steep-Steep",
                        "SbS1kt_r0" : 0.999990032654244,
                        "SbS1kt_r2" : 0.07545622760470719,
                        "pretest2desired_outcome" : "Different Outcome",
                        "posttest1freeresp" : "Only the surface is different.",
                        "SbS2kt_r1" : 0.9996411624681426,
                        "pretest1kt_tov" : 0,
                        "pretest0kt_vvfar" : 0.9,
                        "pretest1goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "pretest0kt_cvlog" : 0,
                        "posttest2freeresp" : "Only the balls are different.",
                        "pretest1se_text" : "To compare several parts of the ramps.",
                        "pretest2kt_r0" : 0,
                        "pretest3selfexp" : "PHRASE4",
                        "pretest0kt_r1" : 0.7499999999999999,
                        "posttest0setup" : "Middle-Top,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest1kt_r0" : 0,
                        "pretest3goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "MAX_PSBS_R1" : 4,
                        "pretest0kt_tov" : 0,
                        "SbS1kt_r1" : 0.9966396927895124,
                        "pretest2kt_r1" : 0.7499999999999999,
                        "posttest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest2se_text" : "To make the ball(s) roll farther / faster/ the same.",
                        "pretest3kt_cvlog" : 0,
                        "pretest0goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "pretest3ramp" : "HOTAT",
                        "pretest1tv_sel" : "false",
                        "SbS3kt_r2" : 0.42354409558897066,
                        "pretest2kt_cvlog" : 0,
                        "pretest2selfexp" : "PHRASE10",
                        "pretest3tv_sel" : "false",
                        "pretest0setup" : "Middle-Top,Sif-Fim,Lof-Bab,Steep-Steep",
                        "pretest3kt_r2" : 0,
                        "posttest0ramp" : "CVS",
                        "pretest2goal" : "ENGINEERING",
                        "SbS2kt_r0" : 0.9999989441911232,
                        "pretest1selfexp" : "PHRASE4",
                        "pretest3kt_r0" : 0,
                        "pretest3goal" : "SCIENCE2",
                        "pretest1goal" : "SCIENCE",
                        "posttest3freeresp" : "Only the slopes are different.",
                        "pretest2kt_vvfar" : 0.990602098298888,
                        "pretest3se_text" : "To compare several parts of the ramps.",
                        "pretest3kt_tov" : 0,
                        "SbS2kt_r2" : 0.016463717721371198,
                        "pretest1setup" : "Top-Top,Fim-Sif,Lof-Lof,Steep-Not-Steep",
                        "pretest0corrTYPE3" : "true",
                        "pretest0tv_text" : "Starting Positions, Surfaces, Balls",
                        "pretest3tv_text" : "Starting Positions, Slopes",
                        "pretest0se_text" : "To compare several parts of the ramps.",
                        "posttest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "MAX_PSBS_R0" : 6,
                        "posttest1ramp" : "CVS",
                        "pretest2kt_r2" : 0,
                        "pretest2setup" : "Top-Middle,Sif-Sif,Lof-Lof,Not-Steep-Not-Steep",
                        "SbS0kt_r1" : 0.9661764855363308,
                        "pretest0goal" : "ENGINEERING",
                        "pretest1tv_text" : "Starting Positions, Surfaces, Slopes",
                        "lastSBS" : "Q4",
                        "pretest3kt_vvfar" : 0.9991731195241144,
                        "pretest0kt_r0" : 0,
                        "pretest3kt_r1" : 0.7499999999999999,
                        "posttest0freeresp" : "Every thing is the same only the starting positions are different.",
                        "pretest0selfexp" : "PHRASE4",
                        "ftrfocuscorrect" : "true",
                        "pretest0kt_r2" : 0,
                        "MAX_PSBS_R2" : 3
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_LOWABILITY:R012_SEEN:MAX_PSBS_R0:PSBS_R1_LRN:MAX_PSBS_R1:MAX_PSBS_R2:MAX_CSBS_R2:EIB_SEEN:EIC_SEEN",
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "ktSkills" : {
                        "rule2" : {
                            "pT" : 0.06,
                            "Bel" : 0.9865642784888814,
                            "pG" : 0.1,
                            "pL" : 0.9873704217795485,
                            "pS" : 0.1
                        },
                        "rule1" : {
                            "pT" : 0.041667,
                            "Bel" : 0,
                            "pG" : 0.1,
                            "pL" : 0.9999633713416234,
                            "pS" : 0.1
                        },
                        "rule_vvfar" : {
                            "pT" : 0.213333,
                            "Bel" : 0,
                            "pG" : 0.1,
                            "pL" : 0.9993495204166766,
                            "pS" : 0.1
                        },
                        "rule0" : {
                            "pT" : 0.046667,
                            "Bel" : 0,
                            "pG" : 0.1,
                            "pL" : 0.9999998933815312,
                            "pS" : 0.1
                        },
                        "rule_tov" : {
                            "pT" : 0.046667,
                            "Bel" : 0,
                            "pG" : 0.1,
                            "pL" : 0.03,
                            "pS" : 0.1
                        },
                        "rule_cvslog" : {
                            "pT" : 0.03,
                            "Bel" : 0,
                            "pG" : 0.1,
                            "pL" : 0.03,
                            "pS" : 0.1
                        }
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER",
                    "ktSkills" : {
    
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    },
                    "globals" : {
                        "q4Good" : "checked",
                        "q4Bad" : "unchecked",
                        "q6Bad" : "checked",
                        "q1CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "Correct_Assessments" : "1",
                        "q5CVS" : "CVS",
                        "q2Good" : "checked",
                        "q6CVS" : "CVS_WV",
                        "q2Bad" : "unchecked",
                        "q3CVS" : "SC",
                        "Correct_Designs" : "2"
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "TuringAl"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Benjamin",
        "isActive" : true,
        "lastname" : "Banneker",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q1CVS" : "MC",
                        "q4Good" : "checked",
                        "q2Good" : "unchecked",
                        "q3CVS" : "MC",
                        "q6Bad" : "unchecked",
                        "q5CVS" : "MC",
                        "q2Bad" : "checked",
                        "q4Bad" : "unchecked",
                        "q6Good" : "checked",
                        "q2CVS" : "SC"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "ktSkills" : {
    
                    }
                }
            },
            "2" : {
                "_features" : "ted2cmbfblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "pretest2kt_cvlog" : 0,
                        "ftrfocuscorrect" : "true",
                        "pretest1setup" : "Top-Middle,Fim-Sif,Lof-Bab,Steep-Not-Steep",
                        "CEIA_IMAG_FB" : "EIC_IMAG_SLFEX_FB_CVSP",
                        "pretest3selfexp" : "PHRASE1",
                        "pretest3ramp" : "CVS_WV",
                        "MAX_PSBS_R2" : 3,
                        "SbS3kt_r1" : 0.9999955068828859,
                        "pretest2kt_tov" : 0,
                        "pretest1kt_vvfar" : 0.9906020982988881,
                        "pretest3cvswvlogic" : "TYPEB",
                        "CEIC_CORR_FB" : "EIC_CORR_SLFEX_FB_CVSP",
                        "pretest0setup" : "Top-Middle,Fim-Sif,Lof-Bab,Steep-Not-Steep",
                        "pretest1goal" : "SCIENCE",
                        "posttest3ramp" : "CVS",
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "SbS1kt_r0" : 0.37123248150066074,
                        "pretest0kt_r1" : 0.7499999999999999,
                        "SbS3kt_r2" : 0.9222247621997512,
                        "SbS0kt_r0" : 0.06741935943837486,
                        "MAX_CSBS_R01" : 1,
                        "pretest0ramp" : "MC",
                        "pretest0kt_r2" : 0,
                        "CEIB_EVAL_FB" : "EIB_EVAL_SLFEX_FB_CVSC",
                        "pretest1kt_cvlog" : 0,
                        "pretest2kt_r2" : 0,
                        "pretest2kt_vvfar" : 0.9906020982988881,
                        "posttest1freeresp" : "Because everythin",
                        "pretest1tv_sel" : "false",
                        "posttest1setup" : "Middle-Middle,Fim-Sif,Bab-Bab,Steep-Steep",
                        "pretest3kt_r2" : 0.32142857142857145,
                        "pretest3kt_vvfar" : 0.9991731195241145,
                        "pretest3kt_tov" : 0.21774193548387097,
                        "SbS0kt_r1" : 0.9999995215645684,
                        "pretest2selfexp" : "PHRASE9",
                        "pretest2kt_r1" : 0.9661764855363307,
                        "pretest0kt_vvfar" : 0.9,
                        "SbS1kt_r2" : 0.32142857142857145,
                        "posttest2setup" : "Top-Top,Fim-Fim,Bab-Lof,Steep-Steep",
                        "pretest3goal" : "SCIENCE",
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "posttest2ramp" : "CVS",
                        "pretest0goal" : "SCIENCE2",
                        "pretest3kt_cvlog" : 0.21774193548387097,
                        "SbS2kt_r2" : 0.5409594015224429,
                        "SbS2kt_r0" : 0.013897246092391197,
                        "pretest2kt_r0" : 0,
                        "pretest0selfexp" : "PHRASE2",
                        "pretest2goal" : "SCIENCE2",
                        "MAX_PSBS_R0" : 5,
                        "posttest2freeresp" : "Because everything is the same but the balls",
                        "pretest0kt_tov" : 0,
                        "pretest1kt_r0" : 0,
                        "pretest1tv_text" : "Starting Positions, Surfaces, Balls, Slopes",
                        "SbS1kt_r1" : 0.9962915738754334,
                        "pretest3kt_r1" : 0.9962915738754334,
                        "pretest1kt_r1" : 0.9661764855363307,
                        "pretest1se_text" : "To see what parts of the ramps mattered.",
                        "pretest0kt_cvlog" : 0,
                        "MAXVAL_CSBS_R2" : 1,
                        "CEIC_EVAL_FB" : "EIC_EVAL_SLFEX_FB_CVSP",
                        "posttest0setup" : "Top-Middle,Fim-Fim,Lof-Lof,Steep-Steep",
                        "SbS0kt_r2" : 0.9913122290811115,
                        "pretest0kt_r0" : 0,
                        "MAX_PSBS_R1" : 3,
                        "pretest1selfexp" : "PHRASE6",
                        "pretest3kt_r0" : 0,
                        "posttest0ramp" : "CVS",
                        "posttest3setup" : "Top-Top,Fim-Fim,Lof-Lof,Not-Steep-Steep",
                        "posttest1ramp" : "CVS",
                        "pretest2desired_outcome" : "Maximize Outcome",
                        "CEIB_CORR_FB" : "EIB_CORR_SLFEX_FB_CVSP",
                        "SbS2kt_r1" : 0.9999578052717211,
                        "pretest2goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest1kt_r2" : 0,
                        "posttest3freeresp" : "Cause everything is the same but the slope",
                        "MAX_CSBS_R2" : 2,
                        "pretest2se_text" : "To make the balls do what I want.",
                        "posttest0freeresp" : "Because everything is the same except the starting postions",
                        "pretest1ramp" : "MC",
                        "pretest3setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest2setup" : "Top-Middle,Fim-Sif,Lof-Bab,Steep-Not-Steep",
                        "pretest1goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest2ramp" : "MC",
                        "lastSBS" : "Q1",
                        "pretest3se_text" : "To have only one part of the ramps different.",
                        "pretest1kt_tov" : 0,
                        "SbS3kt_r0" : 0.3645183454754353,
                        "pretest0se_text" : "To compare everything about the ramps."
                    },
                    "ktSkills" : {
                        "rule_tov" : {
                            "pL" : 0.2542475725806452,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.21774193548387097
                        },
                        "rule0" : {
                            "pL" : 0.11094010019146422,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.06741935943837486
                        },
                        "rule1" : {
                            "pL" : 0.9999995414995375,
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999995215645684
                        },
                        "rule_vvfar" : {
                            "pL" : 0.9993495204166766,
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9991731195241145
                        },
                        "rule_cvslog" : {
                            "pL" : 0.24120967741935484,
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.21774193548387097
                        },
                        "rule2" : {
                            "pL" : 0.999910194527964,
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999044622637915
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:FTR_FB:R012_SEEN:MAX_PSBS_R0:PSBS_R1_LRN:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "END_CLOAK"
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q2Good" : "checked",
                        "q5CVS" : "CVS",
                        "q6Good" : "checked",
                        "q6Bad" : "unchecked",
                        "q2Bad" : "unchecked",
                        "q3CVS" : "CVS",
                        "q4Bad" : "unchecked",
                        "Correct_Designs" : "3",
                        "q1CVS" : "CVS",
                        "Correct_Assessments" : "0",
                        "q4Good" : "checked"
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "2"
                        }
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEA:FTR_ASSESSA:NO_ITER"
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "BannekerBe"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Gregor",
        "isActive" : true,
        "lastname" : "Mendel",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q6CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q1CVS" : "CVS",
                        "q3CVS" : "CVS",
                        "q4CVS" : "CVS",
                        "q4Bad" : "checked",
                        "q4Good" : "unchecked",
                        "q5CVS" : "CVS",
                        "q2Good" : "unchecked",
                        "q2CVS" : "CVS",
                        "q2Bad" : "checked",
                        "q6Bad" : "checked"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE"
            },
            "3" : {
                "_features" : "ted2_hsEX",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "row3" : "phrase3",
                        "AddActive" : false,
                        "SstdForm4" : true,
                        "SstdForm2" : true,
                        "STable3_R2" : true,
                        "row3Correct" : true,
                        "STable2_R2" : true,
                        "probAssess2" : "Sright",
                        "STable4_R3" : true,
                        "row3Complete" : true,
                        "STable1_R1" : true,
                        "STable4_R1" : true,
                        "row2" : "phrase1",
                        "row2Correct" : true,
                        "probAssess4" : "Sright",
                        "probAssess6" : "SplaceKeeper",
                        "SstdForm1" : true,
                        "probAssess1" : "Sright",
                        "SstdForm3" : true,
                        "STable4_R2" : true,
                        "STable3_R1" : true,
                        "STable2_R3" : true,
                        "probAssess7" : "SplaceKeeper",
                        "probAssess3" : "Swrong",
                        "probAssess5" : "SplaceKeeper",
                        "STable2_R1" : true,
                        "STable3_R3" : true,
                        "STable1_R2" : true,
                        "rowCount" : 4
                    },
                    "features" : "FTR_HSEX:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "HIGH_STAKES",
                        "currNode" : {
                            "index" : "27"
                        }
                    }
                }
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "MendelGr"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Mary",
        "isActive" : true,
        "lastname" : "Leakey",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q4Bad" : "checked",
                        "q2CVS" : "SC",
                        "q2Bad" : "checked",
                        "q6Bad" : "checked",
                        "q6CVS" : "CVS",
                        "q2Good" : "unchecked",
                        "q3CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q1CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q4CVS" : "NC",
                        "q6Good" : "unchecked"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE"
            },
            "3" : {
                "_features" : "ted2_hsEX",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "27"
                        },
                        "currNodeID" : "HIGH_STAKES"
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "probAssess6" : "SplaceKeeper",
                        "STable4_R3" : true,
                        "SstdForm4" : true,
                        "AddActive" : false,
                        "STable1_R1" : true,
                        "STable3_R2" : true,
                        "rowCount" : 3,
                        "STable4_R2" : true,
                        "probAssess7" : "SplaceKeeper",
                        "STable2_R2" : true,
                        "probAssess5" : "SplaceKeeper",
                        "probAssess2" : "Swrong",
                        "SstdForm2" : true,
                        "STable2_R3" : true,
                        "STable4_R1" : true,
                        "STable2_R1" : true,
                        "row3Complete" : true,
                        "row3Correct" : true,
                        "row3" : "phrase1",
                        "probAssess4" : "Swrong",
                        "SstdForm3" : true,
                        "STable1_R2" : true,
                        "probAssess1" : "Sright",
                        "row2Correct" : true,
                        "probAssess3" : "Swrong",
                        "row2" : "phrase3",
                        "STable3_R1" : true,
                        "STable3_R3" : true,
                        "SstdForm1" : true
                    },
                    "features" : "FTR_HSEX:NO_ITER"
                }
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "LeakeyMa"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Carl",
        "isActive" : true,
        "lastname" : "Sagan",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q4Bad" : "checked",
                        "q3CVS" : "CVS",
                        "q4CVS" : "CVS_WV",
                        "q1CVS" : "MC",
                        "q5CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q6Bad" : "checked",
                        "q2Good" : "unchecked",
                        "q4Good" : "unchecked",
                        "q6CVS" : "CVS_WV",
                        "q2Bad" : "checked",
                        "q2CVS" : "CVS"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "0"
                        }
                    }
                }
            },
            "2" : {
                "_features" : "ted2cmbfb",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "globals" : {
                        "pretest1tv_text" : "Surfaces",
                        "pretest0corrTYPE2" : "true",
                        "pretest0kt_vvfar" : 0.9,
                        "posttest1setup" : "Middle-Middle,Sif-Fim,Bab-Bab,Steep-Steep",
                        "posttest0freeresp" : "I designed my experiment the way I did because i was testing the starting position, so the starting position was the only different thing\r",
                        "pretest1setup" : "Top-Top,Fim-Fim,Bab-Bab,Steep-Steep",
                        "pretest2kt_vvfar" : 0.990602098298888,
                        "pretest1kt_r2" : 0,
                        "CEIA_EVAL_FB" : "EIA_EVAL_SLFEX_FB_ER2",
                        "posttest3setup" : "Top-Top,Fim-Fim,Lof-Lof,Steep-Not-Steep",
                        "CEIC_EVAL_FB" : "EIC_EVAL_SLFEX_FB_CVSC",
                        "pretest3tv_sel" : "true",
                        "pretest3kt_cvlog" : 0.21774193548387097,
                        "pretest2ramp" : "CVS",
                        "pretest0se_text" : "To compare a part of the ramps.",
                        "pretest3se_text" : "To compare a part of the ramps.",
                        "pretest1corrTYPE1" : "true",
                        "pretest2cvslogic" : "TYPEB",
                        "pretest3goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest2goal" : "SCIENCE",
                        "pretest1kt_r1" : 0.7499999999999999,
                        "pretest1corrTYPE2" : "true",
                        "pretest3ramp" : "CVS",
                        "pretest1ramp" : "NC",
                        "posttest1ramp" : "CVS",
                        "pretest3kt_tov" : 0.9964165910954976,
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest2se_text" : "To have only one part of the ramps different.",
                        "pretest2kt_r1" : 0.9661764855363308,
                        "pretest1selfexp" : "PHRASE6",
                        "CEIB_EVAL_FB" : "EIB_EVAL_SLFEX_FB_CVSC",
                        "pretest3kt_vvfar" : 0.9991731195241144,
                        "posttest1freeresp" : "I designed my experiment the way I did because I was trying to find out if the surface would affect how far the balls rolled.  With that being said, I had everything the same except for the surface on the ramp.",
                        "posttest3ramp" : "CVS",
                        "pretest1kt_cvlog" : 0,
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest2kt_cvlog" : 0.21774193548387097,
                        "pretest3selfexp" : "PHRASE3",
                        "pretest0kt_tov" : 0.21774193548387097,
                        "pretest2kt_r0" : 0.9916797026360296,
                        "pretest2setup" : "Middle-Middle,Sif-Sif,Bab-Lof,Not-Steep-Not-Steep",
                        "pretest0setup" : "Top-Middle,Sif-Sif,Lof-Lof,Steep-Steep",
                        "pretest0kt_r2" : 0,
                        "pretest0corrTYPE1" : "true",
                        "CEIB_CORR_FB" : "EIB_CORR_SLFEX_FB_VE",
                        "pretest0selfexp" : "PHRASE3",
                        "CEIA_CORR_FB" : "EIA_CORR_SLFEX_FB_CVSC",
                        "pretest0tv_text" : "Starting Positions",
                        "pretest1tv_sel" : "true",
                        "pretest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "pretest1goal" : "SCIENCE",
                        "posttest2freeresp" : "I designed my experiment the way i did to find out if the type of ball would affect the distance of of how far the ball rolls.  ",
                        "posttest2ramp" : "CVS",
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest3kt_r2" : 0.32142857142857145,
                        "pretest2goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest0ramp" : "CVS",
                        "pretest2kt_r2" : 0.32142857142857145,
                        "pretest3kt_r1" : 0.9962915738754334,
                        "CEIA_IMAG_FB" : "EIC_IMAG_SLFEX_FB_CVSC",
                        "pretest0goal" : "SCIENCE2",
                        "pretest3goal" : "SCIENCE2",
                        "pretest3corrTYPE1" : "true",
                        "posttest0ramp" : "CVS",
                        "pretest1kt_vvfar" : 0.9,
                        "CEIC_CORR_FB" : "EIC_CORR_SLFEX_FB_VE",
                        "pretest2selfexp" : "PHRASE1",
                        "pretest0tv_sel" : "true",
                        "posttest3freeresp" : "I designed my experiment the way I did because I wanted to find out if the slopewould make a difference in how far the ball would roll.  Each element was the same except for the slope.  One slope was up high, and the other was low.",
                        "pretest1kt_tov" : 0.7541999997703432,
                        "ftrfocuscorrect" : "true",
                        "pretest0kt_cvlog" : 0,
                        "pretest1se_text" : "To see what parts of the ramps mattered.",
                        "pretest0kt_r0" : 0.5625,
                        "pretest1kt_r0" : 0.926353778414466,
                        "pretest3tv_text" : "Slopes",
                        "pretest2kt_tov" : 0.9671133732576164,
                        "pretest3kt_r0" : 0.9991124069722446,
                        "pretest3corrTYPE2" : "true",
                        "pretest1goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "posttest2setup" : "Top-Top,Fim-Fim,Lof-Bab,Steep-Steep",
                        "pretest0corrTYPE3" : "true",
                        "MAXVAL_CSBS_R2" : 1
                    },
                    "ktSkills" : {
                        "rule1" : {
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "Bel" : 0,
                            "pT" : 0.041667,
                            "pL" : 0.9964460928667658
                        },
                        "rule_vvfar" : {
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "Bel" : 0,
                            "pT" : 0.213333,
                            "pL" : 0.9993495204166766
                        },
                        "rule2" : {
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "Bel" : 0,
                            "pT" : 0.06,
                            "pL" : 0.998023079610799
                        },
                        "rule_cvslog" : {
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "Bel" : 0,
                            "pT" : 0.03,
                            "pL" : 0.24120967741935484
                        },
                        "rule_tov" : {
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "Bel" : 0,
                            "pT" : 0.046667,
                            "pL" : 0.996583818038844
                        },
                        "rule0" : {
                            "pS" : 0.1,
                            "pG" : 0.1,
                            "Bel" : 0,
                            "pT" : 0.046667,
                            "pL" : 0.9991538282760708
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_FB:EIA_SEEN:EIB_SEEN:EIC_SEEN"
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "READY"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "SaganCa"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Thomas",
        "isActive" : true,
        "lastname" : "Edison",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "globals" : {
                        "q4Good" : "checked",
                        "q2Good" : "checked",
                        "q6Bad" : "unchecked",
                        "q6Good" : "checked",
                        "q4Bad" : "unchecked",
                        "q2Bad" : "unchecked",
                        "q1CVS" : "MC",
                        "q3CVS" : "MC",
                        "q5CVS" : "CVS_WV",
                        "Correct_Designs" : "0",
                        "Correct_Assessments" : "0"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "ktSkills" : {
    
                    }
                }
            },
            "2" : {
                "_features" : "ted2cmblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
                        "rule1" : {
                            "Bel" : 0.9999995215645684,
                            "pL" : 0.9999995414995375,
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule0" : {
                            "Bel" : 0.9999989441911231,
                            "pL" : 0.9999989934625559,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule_cvslog" : {
                            "Bel" : 0,
                            "pL" : 0.03,
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule2" : {
                            "Bel" : 0.9999770133484478,
                            "pL" : 0.999978392547541,
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule_vvfar" : {
                            "Bel" : 0.9991731195241145,
                            "pL" : 0.9993495204166766,
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule_tov" : {
                            "Bel" : 0.9671133732576165,
                            "pL" : 0.9686480934678033,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        }
                    },
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:MAX_PSBS_R0:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN",
                    "globals" : {
                        "ftrfocuscorrect" : "true",
                        "pretest0goal_se" : "i was trying to see if the starting poit of the ball effected it",
                        "posttest2freeresp" : "so that the onlyy thing differnt is the thing that we are comparing",
                        "pretest3kt_r1" : 0.9962915738754334,
                        "MAX_CSBS_R2" : 2,
                        "pretest0kt_r0" : 0,
                        "pretest1kt_tov" : 0.21774193548387097,
                        "pretest2kt_tov" : 0.7541999997703432,
                        "pretest3se_text" : "To see what parts of the ramps mattered.",
                        "pretest1kt_cvlog" : 0,
                        "pretest0kt_r1" : 0,
                        "pretest2se_text" : "To see what parts of the ramps mattered.",
                        "pretest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "posttest3setup" : "Top-Top,Sif-Sif,Lof-Bab,Steep-Not-Steep",
                        "pretest3kt_tov" : 0.9671133732576165,
                        "pretest0kt_r2" : 0,
                        "pretest2kt_cvlog" : 0,
                        "pretest2kt_vvfar" : 0.9906020982988881,
                        "pretest0kt_vvfar" : 0,
                        "SbS0kt_r2" : 0.9801970527952771,
                        "pretest2tv_text" : "Balls",
                        "SbS3kt_r0" : 0.9991124069722446,
                        "pretest1tv_text" : "Surfaces",
                        "pretest0kt_tov" : 0,
                        "pretest3kt_r0" : 0.9916797026360296,
                        "pretest2kt_r2" : 0,
                        "posttest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "lastSBS" : "Q2",
                        "pretest2kt_r1" : 0.9661764855363307,
                        "pretest0kt_cvlog" : 0,
                        "posttest3freeresp" : "i accidently canged the brand of the balls",
                        "pretest3selfexp" : "PHRASE6",
                        "SbS1kt_r2" : 0.9978968932029776,
                        "pretest3corrTYPE2" : "true",
                        "pretest3kt_vvfar" : 0.9991731195241145,
                        "pretest2kt_r0" : 0.9263537784144659,
                        "MAX_PSBS_R0" : 3,
                        "pretest1goal" : "SCIENCE2",
                        "pretest2tv_sel" : "true",
                        "SbS0kt_r1" : 0.9999955068828859,
                        "pretest3kt_r2" : 0,
                        "pretest3kt_cvlog" : 0,
                        "MAX_PSBS_R2" : 3,
                        "SbS3kt_r1" : 0.9996038700437944,
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest2corrTYPE3" : "true",
                        "pretest1corrTYPE1" : "true",
                        "pretest3corrTYPE1" : "true",
                        "MAX_CSBS_R01" : 1,
                        "MAX_PSBS_R1" : 3,
                        "pretest1corrTYPE2" : "true",
                        "pretest2corrTYPE2" : "true",
                        "SbS1kt_r0" : 0.9999989441911231,
                        "posttest0ramp" : "CVS",
                        "pretest2goal" : "SCIENCE2",
                        "pretest1corrTYPE3" : "true",
                        "pretest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "SbS0kt_r0" : 0.999990032654244,
                        "posttest1ramp" : "CVS",
                        "pretest1tv_sel" : "true",
                        "pretest3tv_text" : "Slopes",
                        "pretest3ramp" : "CVS",
                        "pretest3goal" : "SCIENCE2",
                        "posttest1freeresp" : "so  that the only thng differnt is the surface of the ball",
                        "pretest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest2corrTYPE1" : "true",
                        "pretest1ramp" : "CVS",
                        "pretest3goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest0ramp" : "CVS",
                        "posttest3ramp" : "SC",
                        "pretest1selfexp" : "PHRASE6",
                        "pretest1kt_r0" : 0.5625,
                        "pretest2goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0goal" : "NONE",
                        "pretest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest1kt_r1" : 0.7499999999999999,
                        "posttest2ramp" : "CVS",
                        "pretest3tv_sel" : "true",
                        "SbS3kt_r2" : 0.32142857142857145,
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest2selfexp" : "PHRASE6",
                        "pretest1se_text" : "To see what parts of the ramps mattered.",
                        "pretest1kt_vvfar" : 0.9,
                        "pretest1kt_r2" : 0,
                        "pretest0goal_text" : "I wasn't trying to do any of these things; I just guessed.",
                        "SbS1kt_r1" : 0.9999995215645684,
                        "pretest2ramp" : "CVS",
                        "posttest0freeresp" : "i kept every thing the same and changed the starting points to see if they effected the jball\r"
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "features" : "FTR_POSTTEST:FTR_TYPEA:FTR_ASSESSA:NO_ITER",
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q4Good" : "unchecked",
                        "q4CVS" : "CVS",
                        "Correct_Assessments" : "3",
                        "q1CVS" : "CVS",
                        "q3CVS" : "CVS",
                        "q4Bad" : "checked",
                        "q2CVS" : "CVS",
                        "q6Bad" : "checked",
                        "q2Bad" : "checked",
                        "q6Good" : "unchecked",
                        "q2Good" : "unchecked",
                        "Correct_Designs" : "6",
                        "q6CVS" : "CVS",
                        "q5CVS" : "CVS"
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "2"
                        }
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "EdisonTh"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "George",
        "isActive" : true,
        "lastname" : "Carver",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q5CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q4Good" : "unchecked",
                        "q4CVS" : "SC",
                        "q6CVS" : "CVS",
                        "q1CVS" : "CVS",
                        "q3CVS" : "CVS",
                        "q2Good" : "unchecked",
                        "q4Bad" : "checked",
                        "q2CVS" : "CVS",
                        "q2Bad" : "checked",
                        "q6Bad" : "checked"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    }
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE"
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_HSCC:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "HIGH_STAKES",
                        "currNode" : {
                            "index" : "48"
                        }
                    },
                    "globals" : {
                        "probAssess2" : "Sright",
                        "probAssess6" : "Swrong",
                        "probAssess7" : "Swrong",
                        "probAssess4" : "Sright",
                        "probAssess3" : "Sright",
                        "probAssess5" : "Swrong",
                        "probAssess1" : "Sright"
                    }
                }
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "CarverGe"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Margaret",
        "isActive" : true,
        "lastname" : "Mead",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q2Bad" : "checked",
                        "q6Bad" : "unchecked",
                        "q2Good" : "unchecked",
                        "q2CVS" : "NC",
                        "q1CVS" : "MC",
                        "q4Good" : "unchecked",
                        "q4CVS" : "SC",
                        "q5CVS" : "MC",
                        "q3CVS" : "MC",
                        "q6Good" : "checked",
                        "q4Bad" : "checked"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2cmbfblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
                        "rule0" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pT" : 0.046667,
                            "pL" : 0.16940094177956444,
                            "pG" : 0.1
                        },
                        "rule_vvfar" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pT" : 0.213333,
                            "pL" : 0.9926069808624914,
                            "pG" : 0.1
                        },
                        "rule_cvslog" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pT" : 0.03,
                            "pL" : 0.03,
                            "pG" : 0.1
                        },
                        "rule1" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pT" : 0.041667,
                            "pL" : 0.9970012351120094,
                            "pG" : 0.1
                        },
                        "rule_tov" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pT" : 0.046667,
                            "pL" : 0.7656707483810606,
                            "pG" : 0.1
                        },
                        "rule2" : {
                            "Bel" : 0,
                            "pS" : 0.1,
                            "pT" : 0.06,
                            "pL" : 0.9986462406787252,
                            "pG" : 0.1
                        }
                    },
                    "globals" : {
                        "pretest0corrTYPE2" : "true",
                        "pretest3kt_r2" : 0,
                        "pretest0setup" : "Top-Middle,Sif-Fim,Lof-Bab,Steep-Not-Steep",
                        "pretest3kt_r1" : 0.9661764855363308,
                        "CEIA_IMAG_FB" : "EIC_IMAG_SLFEX_FB_CVSC",
                        "pretest2kt_r0" : 0,
                        "pretest1setup" : "Middle-Top,Fim-Sif,Bab-Lof,Not-Steep-Steep",
                        "CEIB_EVAL_FB" : "EIB_EVAL_SLFEX_FB_OF",
                        "pretest3goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "pretest2desired_outcome" : "Maximize Outcome",
                        "posttest0freeresp" : "to show how everything is the same so the starting distances are different that wat i can show hof far eather ball rools\r",
                        "pretest3selfexp" : "PHRASE10",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "SbS3kt_r0" : 0.07637081348079199,
                        "SbS1kt_r0" : 0.12874194198623612,
                        "pretest0kt_cvlog" : 0,
                        "pretest1kt_r1" : 0.9661764855363308,
                        "MAX_PSBS_R1" : 3,
                        "pretest1se_text" : "To compare a part of the ramps.",
                        "pretest2se_text" : "To make the balls land where I want.",
                        "MAX_CSBS_R2" : 4,
                        "posttest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "lastSBS" : "Q2",
                        "pretest3kt_cvlog" : 0,
                        "pretest3kt_vvfar" : 0.990602098298888,
                        "posttest1ramp" : "CVS",
                        "pretest2kt_r2" : 0,
                        "posttest1freeresp" : "so the surfaces are different\r",
                        "pretest0selfexp" : "PHRASE6",
                        "pretest0goal" : "SCIENCE",
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "MAX_PSBS_R2" : 3,
                        "pretest3goal" : "ENGINEERING",
                        "pretest1goal" : "SCIENCE2",
                        "pretest3ramp" : "MC",
                        "SbS2kt_r1" : 0.9996038700437944,
                        "SbS0kt_r1" : 0.9996361882856498,
                        "pretest3se_text" : "To make the ball(s) roll farther / faster/ the same.",
                        "pretest0kt_vvfar" : 0.9,
                        "posttest0ramp" : "CVS",
                        "pretest2kt_r1" : 0.9661764855363308,
                        "pretest1kt_r0" : 0,
                        "MAXVAL_CSBS_R2" : 1,
                        "CEIC_CORR_FB" : "EIC_CORR_SLFEX_FB_CVSP",
                        "pretest0tv_text" : "Slopes",
                        "pretest2kt_cvlog" : 0,
                        "posttest0setup" : "Top-Middle,Fim-Fim,Bab-Bab,Steep-Steep",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "MAX_PSBS_R0" : 5,
                        "MAX_CSBS_R01" : 2,
                        "SbS2kt_r0" : 0.39859572618158023,
                        "ftrfocuscorrect" : "false",
                        "SbS3kt_r1" : 0.9999578052717212,
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest2setup" : "Middle-Middle,Sif-Sif,Lof-Bab,Steep-Steep",
                        "CEIB_CORR_FB" : "EIB_CORR_SLFEX_FB_CVSP",
                        "pretest1kt_r2" : 0,
                        "SbS3kt_r2" : 0.8686074031405745,
                        "pretest2selfexp" : "PHRASE5",
                        "posttest2ramp" : "CVS",
                        "pretest3setup" : "Top-Middle,Sif-Fim,Bab-Lof,Steep-Not-Steep",
                        "pretest1corrTYPE2" : "true",
                        "pretest3desired_outcome" : "Maximize Outcome",
                        "SbS0kt_r0" : 0.5497850265437209,
                        "posttest2freeresp" : "Everything but the ball is the same so it will tell wich one goes farther for what brand of ball it is",
                        "pretest0se_text" : "To see what parts of the ramps mattered.",
                        "pretest0goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "posttest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest1selfexp" : "PHRASE3",
                        "posttest3ramp" : "CVS",
                        "pretest3kt_tov" : 0.7541999997703432,
                        "SbS1kt_r2" : 0.9985598305092822,
                        "pretest2kt_tov" : 0.7541999997703432,
                        "SbS2kt_r2" : 0.3866758241758242,
                        "posttest3freeresp" : "to show how different slopes make balls roll different distances\r",
                        "pretest3kt_r0" : 0,
                        "pretest1ramp" : "MC",
                        "pretest0kt_tov" : 0.21774193548387097,
                        "SbS0kt_r2" : 0.9845843539644772,
                        "pretest1kt_tov" : 0.7541999997703432,
                        "pretest0kt_r2" : 0,
                        "pretest2kt_vvfar" : 0.990602098298888,
                        "pretest0ramp" : "MC",
                        "pretest2goal" : "ENGINEERING",
                        "CEIC_EVAL_FB" : "EIC_EVAL_SLFEX_FB_CVSC",
                        "pretest1kt_vvfar" : 0.990602098298888,
                        "SbS1kt_r1" : 0.996870852941524,
                        "pretest1tv_sel" : "false",
                        "pretest1kt_cvlog" : 0,
                        "pretest2ramp" : "CVS",
                        "pretest1tv_text" : "Slopes",
                        "pretest0kt_r0" : 0,
                        "pretest0tv_sel" : "false"
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:FTR_FB:R012_SEEN:MAX_PSBS_R0:PSBS_R1_LRN:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN:MAX_CSBS_R2",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "END_CLOAK"
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q4CVS" : "CVS",
                        "Correct_Designs" : "5",
                        "q2CVS" : "NC",
                        "Correct_Assessments" : "3",
                        "q2Bad" : "checked",
                        "q4Good" : "unchecked",
                        "q6Bad" : "checked",
                        "q2Good" : "unchecked",
                        "q6CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q4Bad" : "checked",
                        "q1CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q3CVS" : "CVS"
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    },
                    "ktSkills" : {
    
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "MeadMa"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Richard",
        "isActive" : true,
        "lastname" : "Feynman",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q2Good" : "checked",
                        "q6CVS" : "MC",
                        "q2Bad" : "unchecked",
                        "q6Good" : "unchecked",
                        "q3CVS" : "MC",
                        "q4CVS" : "MC",
                        "q4Good" : "unchecked",
                        "q6Bad" : "checked",
                        "q4Bad" : "checked",
                        "q5CVS" : "MC",
                        "q1CVS" : "MC"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER",
                    "ktSkills" : {
    
                    }
                }
            },
            "2" : {
                "_features" : "ted2cmblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "SbS0kt_r2" : 0.865324226219378,
                        "pretest2kt_cvlog" : 0,
                        "pretest1selfexp" : "PHRASE1",
                        "MAX_PSBS_R1" : 3,
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0tv_text" : "Starting Positions, Surfaces, Slopes",
                        "pretest1se_text" : "To have only one part of the ramps different.",
                        "SbS0kt_r0" : 0.9926869676585278,
                        "pretest0ramp" : "MC",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0goal" : "SCIENCE2",
                        "posttest1setup" : "Top-Top,Sif-Fim,Lof-Lof,Steep-Steep",
                        "pretest3goal" : "SCIENCE",
                        "pretest1kt_r0" : 0.5625,
                        "MAX_CSBS_R2" : 2,
                        "pretest0kt_r0" : 0,
                        "ftrfocuscorrect" : "true",
                        "SbS2kt_r2" : 0.9841503127260885,
                        "pretest3kt_r2" : 0.8363269794721407,
                        "SbS3kt_r1" : 0.9999995215645684,
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest0setup" : "Top-Middle,Sif-Fim,Bab-Lof,Steep-Not-Steep",
                        "pretest3kt_vvfar" : 0.9991731195241145,
                        "SbS3kt_r2" : 0.9983223708819967,
                        "pretest1goal" : "SCIENCE2",
                        "pretest3kt_r1" : 0.9962915738754334,
                        "posttest3ramp" : "CVS",
                        "SbS2kt_r1" : 0.9999955068828859,
                        "pretest3ramp" : "CVS",
                        "SbS1kt_r0" : 0.9347767001592616,
                        "pretest2se_text" : "To make the ball(s) roll farther / faster/ the same.",
                        "pretest0kt_r2" : 0,
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest1kt_r2" : 0.32142857142857145,
                        "pretest3setup" : "Top-Top,Fim-Fim,Bab-Bab,Steep-Not-Steep",
                        "posttest1ramp" : "CVS",
                        "pretest1kt_r1" : 0.9661764855363307,
                        "pretest0kt_vvfar" : 0.9,
                        "pretest1ramp" : "CVS",
                        "pretest1kt_vvfar" : 0.9906020982988881,
                        "pretest0kt_tov" : 0,
                        "SbS3kt_r0" : 0.9999173793829801,
                        "pretest1kt_tov" : 0.21774193548387097,
                        "pretest1setup" : "Middle-Middle,Fim-Sif,Lof-Lof,Steep-Steep",
                        "posttest0setup" : "Top-Middle,Sif-Sif,Lof-Lof,Steep-Steep",
                        "pretest0kt_cvlog" : 0,
                        "pretest3kt_r0" : 0.9263537784144659,
                        "pretest1kt_cvlog" : 0,
                        "SbS0kt_r1" : 0.9999578052717211,
                        "pretest2ramp" : "CVS",
                        "MAX_PSBS_R2" : 3,
                        "posttest0ramp" : "CVS",
                        "pretest3cvslogic" : "TYPEA",
                        "posttest2setup" : "Top-Top,Fim-Fim,Lof-Bab,Steep-Steep",
                        "pretest2selfexp" : "PHRASE10",
                        "posttest2ramp" : "CVS",
                        "pretest0tv_sel" : "false",
                        "MAX_CSBS_R01" : 1,
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "pretest3kt_cvlog" : 0,
                        "pretest2kt_r0" : 0.5625,
                        "pretest2desired_outcome" : "Maximize Outcome",
                        "pretest2setup" : "Top-Top,Fim-Fim,Bab-Lof,Steep-Steep",
                        "pretest3kt_tov" : 0.7541999997703432,
                        "pretest2kt_r1" : 0.9661764855363307,
                        "MAX_PSBS_R0" : 4,
                        "SbS1kt_r1" : 0.9996038700437944,
                        "pretest3selfexp" : "PHRASE1",
                        "posttest2freeresp" : "everything is the same except for the type of ball",
                        "pretest2kt_r2" : 0.32142857142857145,
                        "lastSBS" : "Q4",
                        "pretest3se_text" : "To have only one part of the ramps different.",
                        "pretest2kt_vvfar" : 0.9906020982988881,
                        "posttest0freeresp" : "i put everything the same except for the starting position.",
                        "SbS1kt_r2" : 0.37929861576684926,
                        "pretest1cvslogic" : "TYPEA",
                        "pretest0se_text" : "To see what parts of the ramps mattered.",
                        "pretest2kt_tov" : 0.21774193548387097,
                        "pretest2goal" : "ENGINEERING",
                        "SbS2kt_r0" : 0.9992205300835698,
                        "pretest0selfexp" : "PHRASE6",
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "posttest3freeresp" : "the only thing that can effect the differences is the slopes",
                        "posttest3setup" : "Top-Top,Fim-Fim,Lof-Lof,Steep-Not-Steep",
                        "posttest1freeresp" : "everything is the same except the surface"
                    },
                    "ktSkills" : {
                        "rule0" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999173793829801,
                            "pL" : 0.9999212350393145,
                            "pT" : 0.046667
                        },
                        "rule1" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999995215645684,
                            "pL" : 0.9999995414995375,
                            "pT" : 0.041667
                        },
                        "rule2" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999816709683552,
                            "pL" : 0.9999827707102539,
                            "pT" : 0.06
                        },
                        "rule_cvslog" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0,
                            "pL" : 0.03,
                            "pT" : 0.03
                        },
                        "rule_vvfar" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9991731195241145,
                            "pL" : 0.9993495204166766,
                            "pT" : 0.213333
                        },
                        "rule_tov" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.7541999997703432,
                            "pL" : 0.7656707483810606,
                            "pT" : 0.046667
                        }
                    },
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:MAX_PSBS_R0:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN"
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "3"
                        },
                        "currNodeID" : "node6"
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q4Bad" : "checked",
                        "q1CVS" : "MC",
                        "Correct_Assessments" : "3",
                        "q6CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q4CVS" : "CVS",
                        "q6Bad" : "checked",
                        "q2Good" : "unchecked",
                        "q2CVS" : "CVS",
                        "q2Bad" : "checked",
                        "Correct_Designs" : "5",
                        "q3CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q5CVS" : "CVS"
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER"
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "FeynmanRi"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Rosalind",
        "isActive" : true,
        "lastname" : "Franklin",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q4Bad" : "checked",
                        "q4Good" : "unchecked",
                        "q4CVS" : "CVS",
                        "q2Bad" : "checked",
                        "q3CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q2Good" : "unchecked",
                        "q1CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q6Bad" : "checked",
                        "q2CVS" : "CVS",
                        "q6CVS" : "CVS"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    }
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE"
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "48"
                        },
                        "currNodeID" : "HIGH_STAKES"
                    },
                    "globals" : {
                        "probAssess5" : "Swrong",
                        "probAssess4" : "Sright",
                        "probAssess7" : "Sright",
                        "probAssess6" : "Swrong",
                        "probAssess3" : "Swrong",
                        "probAssess1" : "Sright",
                        "probAssess2" : "Sright"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_HSCC:NO_ITER"
                }
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "FranklinRo"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Galileo",
        "isActive" : true,
        "lastname" : "Galilei",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q6CVS" : "CVS_WV",
                        "q2Good" : "checked",
                        "q4CVS" : "CVS",
                        "q4Bad" : "checked",
                        "q3CVS" : "MC",
                        "q6Bad" : "checked",
                        "q6Good" : "unchecked",
                        "q2Bad" : "unchecked",
                        "q5CVS" : "SC",
                        "q4Good" : "unchecked",
                        "q1CVS" : "MC"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2low",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
                        "rule0" : {
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "Bel" : 0.9916797026360296,
                            "pS" : 0.1,
                            "pL" : 0.992067985953114
                        },
                        "rule_vvfar" : {
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "Bel" : 0.9,
                            "pS" : 0.1,
                            "pL" : 0.9213333
                        },
                        "rule1" : {
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "Bel" : 0.9962915738754334,
                            "pS" : 0.1,
                            "pL" : 0.9964460928667658
                        },
                        "rule2" : {
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "Bel" : 0.9981619934738747,
                            "pS" : 0.1,
                            "pL" : 0.9982722738654422
                        },
                        "rule_cvslog" : {
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "Bel" : 0.21774193548387097,
                            "pS" : 0.1,
                            "pL" : 0.24120967741935484
                        },
                        "rule_tov" : {
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "Bel" : 0.21774193548387097,
                            "pS" : 0.1,
                            "pL" : 0.2542475725806452
                        }
                    },
                    "globals" : {
                        "pretest1goal" : "SCIENCE2",
                        "posttest0ramp" : "CVS",
                        "pretest3ramp" : "CVS",
                        "posttest3ramp" : "CVS",
                        "pretest0kt_r0" : 0,
                        "posttest3freeresp" : "so only the problem if the ball went farther than the other is is the slope ",
                        "pretest1selfexp" : "PHRASE1",
                        "pretest0kt_r1" : 0,
                        "pretest3kt_vvfar" : 0.9,
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0se_text" : "To make the balls do what I want.",
                        "pretest1kt_cvlog" : 0.21774193548387097,
                        "posttest1ramp" : "CVS",
                        "pretest2kt_r0" : 0.9263537784144659,
                        "pretest0selfexp" : "PHRASE9",
                        "pretest1kt_tov" : 0.21774193548387097,
                        "pretest2kt_r1" : 0.9661764855363307,
                        "pretest0desired_outcome" : "Other Outcome",
                        "pretest1kt_vvfar" : 0.9,
                        "pretest1se_text" : "To have only one part of the ramps different.",
                        "posttest1freeresp" : "so only the surface will be noticed as the problem in my expeirment",
                        "pretest2kt_r2" : 0.8363269794721407,
                        "posttest0setup" : "Top-Middle,Fim-Fim,Lof-Lof,Steep-Steep",
                        "pretest3kt_r2" : 0.9801970527952771,
                        "pretest3selfexp" : "PHRASE1",
                        "pretest1ramp" : "CVS",
                        "pretest1kt_r2" : 0.32142857142857145,
                        "ftrfocuscorrect" : "true",
                        "pretest2kt_vvfar" : 0.9,
                        "pretest2se_text" : "To have only one part of the ramps different.",
                        "pretest2selfexp" : "PHRASE1",
                        "pretest2ramp" : "CVS",
                        "pretest2goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest2kt_tov" : 0.21774193548387097,
                        "pretest0kt_cvlog" : 0,
                        "posttest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Not-Steep-Not-Steep",
                        "pretest0kt_tov" : 0,
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest0setup" : "Top-Middle,Sif-Fim,Lof-Bab,Steep-Not-Steep",
                        "pretest2setup" : "Middle-Middle,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest1kt_r1" : 0.7499999999999999,
                        "pretest2kt_cvlog" : 0.21774193548387097,
                        "pretest1kt_r0" : 0.5625,
                        "pretest3goal" : "SCIENCE2",
                        "pretest0ramp" : "MC",
                        "posttest2setup" : "Top-Top,Sif-Sif,Lof-Bab,Steep-Steep",
                        "pretest1cvslogic" : "TYPEB",
                        "pretest0kt_vvfar" : 0,
                        "posttest3setup" : "Top-Top,Sif-Sif,Lof-Lof,Not-Steep-Steep",
                        "posttest2freeresp" : "so only the type of ball will be noticed as a problem",
                        "pretest3kt_r1" : 0.9962915738754334,
                        "posttest0freeresp" : "so that way only the starting postion is going to make a diffrence in my experiment\r",
                        "pretest3se_text" : "To have only one part of the ramps different.",
                        "pretest3kt_r0" : 0.9916797026360296,
                        "pretest3cvslogic" : "TYPEC",
                        "posttest2ramp" : "CVS",
                        "pretest3setup" : "Top-Top,Fim-Fim,Bab-Bab,Steep-Not-Steep",
                        "pretest2goal" : "SCIENCE2",
                        "pretest2cvslogic" : "TYPEC",
                        "pretest1setup" : "Top-Top,Fim-Sif,Bab-Bab,Not-Steep-Not-Steep",
                        "pretest0goal" : "SCIENCE2",
                        "pretest3kt_cvlog" : 0.21774193548387097,
                        "pretest0kt_r2" : 0,
                        "pretest3kt_tov" : 0.21774193548387097,
                        "pretest3goal_text" : "I'm trying to find out if a part of the ramps makes a difference."
                    },
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "END_CLOAK"
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_LOWABILITY:EIA_SEEN:EIB_SEEN:EIC_SEEN"
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "2"
                        }
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q4CVS" : "CVS",
                        "q2Good" : "unchecked",
                        "Correct_Assessments" : "3",
                        "q4Bad" : "checked",
                        "q6Bad" : "checked",
                        "q4Good" : "unchecked",
                        "Correct_Designs" : "5",
                        "q3CVS" : "CVS",
                        "q2CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q2Bad" : "checked",
                        "q6CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q1CVS" : "MC"
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEA:FTR_ASSESSA:NO_ITER"
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "GalileiGa"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Louis",
        "isActive" : true,
        "lastname" : "Pasteur",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q6Good" : "unchecked",
                        "q2Good" : "unchecked",
                        "q1CVS" : "CVS",
                        "q2CVS" : "CVS",
                        "q4Bad" : "checked",
                        "q6Bad" : "checked",
                        "q5CVS" : "CVS",
                        "q4CVS" : "CVS",
                        "q2Bad" : "checked",
                        "q3CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q6CVS" : "CVS"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE"
            },
            "3" : {
                "_features" : "ted2_hsEX",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "STable4_R2" : true,
                        "STable2_R3" : true,
                        "row3Complete" : true,
                        "row3Correct" : true,
                        "probAssess7" : "SplaceKeeper",
                        "probAssess4" : "Swrong",
                        "rowCount" : 4,
                        "SstdForm1" : true,
                        "STable2_R1" : true,
                        "probAssess3" : "Swrong",
                        "SstdForm3" : true,
                        "STable1_R1" : true,
                        "probAssess6" : "SplaceKeeper",
                        "STable3_R2" : true,
                        "SstdForm4" : true,
                        "STable4_R3" : true,
                        "STable4_R1" : true,
                        "STable3_R1" : true,
                        "probAssess2" : "Swrong",
                        "probAssess5" : "SplaceKeeper",
                        "STable2_R2" : true,
                        "SstdForm2" : true,
                        "row2" : "phrase1",
                        "row3" : "phrase3",
                        "AddActive" : false,
                        "STable3_R3" : true,
                        "STable1_R2" : true,
                        "row2Correct" : true,
                        "probAssess1" : "Sright"
                    },
                    "features" : "FTR_HSEX:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "HIGH_STAKES",
                        "currNode" : {
                            "index" : "27"
                        }
                    }
                }
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "PasteurLo"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Jonas",
        "isActive" : true,
        "lastname" : "Salk",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q2Bad" : "checked",
                        "q2CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q3CVS" : "MC",
                        "q6CVS" : "CVS",
                        "q4CVS" : "MC",
                        "q6Bad" : "checked",
                        "q4Bad" : "checked",
                        "q2Good" : "unchecked",
                        "q1CVS" : "MC",
                        "q5CVS" : "MC",
                        "q6Good" : "unchecked"
                    }
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:R012_SEEN:PSBS_R0_LRN:EIA_SEEN:EIB_SEEN:EIC_SEEN",
                    "ktSkills" : {
                        "rule_tov" : {
                            "Bel" : 0.7541999997703432,
                            "pL" : 0.7656707483810606,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule_vvfar" : {
                            "Bel" : 0.9991731195241145,
                            "pL" : 0.9993495204166766,
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule2" : {
                            "Bel" : 0.9978968932029776,
                            "pL" : 0.998023079610799,
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule1" : {
                            "Bel" : 0.9996038700437944,
                            "pL" : 0.9996203755906796,
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule0" : {
                            "Bel" : 0.9916797026360296,
                            "pL" : 0.992067985953114,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule_cvslog" : {
                            "Bel" : 0,
                            "pL" : 0.03,
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "pS" : 0.1
                        }
                    },
                    "globals" : {
                        "pretest0kt_vvfar" : 0.9,
                        "pretest1kt_r1" : 0.9661764855363307,
                        "posttest3ramp" : "CVS",
                        "pretest1kt_r2" : 0,
                        "pretest2ramp" : "CVS",
                        "pretest3goal" : "SCIENCE",
                        "pretest1kt_vvfar" : 0.9906020982988881,
                        "SbS3kt_r2" : 0.32142857142857145,
                        "pretest0kt_cvlog" : 0,
                        "posttest1ramp" : "CVS",
                        "pretest1kt_tov" : 0.21774193548387097,
                        "pretest0se_text" : "To see what parts of the ramps mattered.",
                        "lastSBS" : "Q4Q",
                        "pretest3kt_r0" : 0.9263537784144659,
                        "pretest1kt_cvlog" : 0,
                        "pretest2kt_tov" : 0.21774193548387097,
                        "pretest2desired_outcome" : "Other Outcome",
                        "pretest2selfexp" : "PHRASE9",
                        "posttest1setup" : "Middle-Middle,Fim-Sif,Lof-Lof,Steep-Steep",
                        "pretest2kt_vvfar" : 0.9906020982988881,
                        "posttest0setup" : "Middle-Top,Sif-Sif,Lof-Lof,Steep-Steep",
                        "pretest2kt_cvlog" : 0,
                        "SbS3kt_r1" : 0.9996038700437944,
                        "SbS3kt_r0" : 0.9916797026360296,
                        "pretest2setup" : "Top-Top,Fim-Fim,Bab-Lof,Steep-Steep",
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest2kt_r2" : 0,
                        "pretest1selfexp" : "PHRASE6",
                        "pretest1ramp" : "MC",
                        "posttest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Not-Steep-Steep",
                        "pretest3kt_r1" : 0.9962915738754334,
                        "pretest1tv_sel" : "false",
                        "pretest3cvslogic" : "TYPEA",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest3kt_vvfar" : 0.9991731195241145,
                        "pretest0setup" : "Middle-Top,Fim-Sif,Bab-Lof,Steep-Not-Steep",
                        "pretest2kt_r0" : 0.5625,
                        "pretest0ramp" : "MC",
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest1tv_text" : "Starting Positions, Surfaces, Slopes",
                        "pretest3setup" : "Top-Top,Fim-Fim,Lof-Lof,Steep-Not-Steep",
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest3kt_tov" : 0.7541999997703432,
                        "pretest0corrTYPE2" : "true",
                        "pretest0kt_r0" : 0.5625,
                        "pretest0kt_tov" : 0.21774193548387097,
                        "pretest2kt_r1" : 0.9661764855363307,
                        "pretest3kt_cvlog" : 0,
                        "pretest2goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0corrTYPE3" : "true",
                        "pretest0goal" : "SCIENCE2",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest1setup" : "Top-Middle,Sif-Fim,Lof-Bab,Steep-Not-Steep",
                        "pretest1goal" : "SCIENCE2",
                        "pretest0tv_text" : "Starting Positions",
                        "pretest2goal" : "SCIENCE2",
                        "pretest3ramp" : "CVS",
                        "pretest3kt_r2" : 0.32142857142857145,
                        "pretest3se_text" : "To have only one part of the ramps different.",
                        "posttest2ramp" : "CVS",
                        "pretest0tv_sel" : "true",
                        "pretest0corrTYPE1" : "true",
                        "pretest0kt_r2" : 0,
                        "pretest2se_text" : "To make the balls do what I want.",
                        "posttest2freeresp" : "Because everything is the same other than the thing im testing.  ",
                        "pretest0selfexp" : "PHRASE6",
                        "pretest1se_text" : "To see what parts of the ramps mattered.",
                        "posttest0freeresp" : "everything is the same but the thing i'm testing.",
                        "MAX_PSBS_R0" : 1,
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "posttest3freeresp" : "Because everything is the same other than the thing i am testing.  ",
                        "pretest3selfexp" : "PHRASE1",
                        "ftrfocuscorrect" : "true",
                        "posttest0ramp" : "CVS",
                        "posttest1freeresp" : "Because everything is the same but the thing im testing.  ",
                        "pretest1kt_r0" : 0.5625
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "2"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "Correct_Designs" : "4",
                        "q4Bad" : "checked",
                        "q6Bad" : "checked",
                        "q2Bad" : "checked",
                        "q4Good" : "unchecked",
                        "q1CVS" : "CVS",
                        "q2CVS" : "CVS",
                        "q4CVS" : "CVS",
                        "q2Good" : "unchecked",
                        "q6Good" : "unchecked",
                        "Correct_Assessments" : "3",
                        "q6CVS" : "CVS",
                        "q3CVS" : "MC",
                        "q5CVS" : "CVS_WV"
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEA:FTR_ASSESSA:NO_ITER",
                    "ktSkills" : {
    
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "SalkJo"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Edmond",
        "isActive" : true,
        "lastname" : "Halley",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTB-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q2CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q6Bad" : "checked",
                        "q2Bad" : "checked",
                        "q4CVS" : "CVS",
                        "q1CVS" : "CVS",
                        "q3CVS" : "CVS",
                        "q2Good" : "unchecked",
                        "q4Good" : "unchecked",
                        "q6Good" : "unchecked",
                        "q4Bad" : "checked",
                        "q6CVS" : "CVS"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEB:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    }
                }
            },
            "2" : {
                "_features" : "ted2",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE"
            },
            "3" : {
                "_features" : "ted2_hsEX",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE",
                "stateData" : {
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_HSEX:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "HIGH_STAKES",
                        "currNode" : {
                            "index" : "27"
                        }
                    },
                    "globals" : {
                        "STable2_R3" : true,
                        "rowCount" : 3,
                        "row2" : "phrase1",
                        "STable3_R3" : true,
                        "STable1_R2" : true,
                        "SstdForm3" : true,
                        "AddActive" : true,
                        "probAssess7" : "SplaceKeeper",
                        "STable1_R1" : true,
                        "SstdForm2" : true,
                        "row2Correct" : true,
                        "STable2_R1" : true,
                        "STable3_R2" : true,
                        "row3" : "phrase3",
                        "probAssess5" : "SplaceKeeper",
                        "probAssess2" : "Sright",
                        "probAssess1" : "Swrong",
                        "row3Correct" : true,
                        "STable2_R2" : true,
                        "SstdForm1" : true,
                        "row3Complete" : true,
                        "probAssess6" : "SplaceKeeper",
                        "STable4_R1" : true,
                        "STable3_R1" : true,
                        "STable4_R3" : true,
                        "probAssess4" : "Sright",
                        "SstdForm4" : true,
                        "STable4_R2" : true,
                        "probAssess3" : "Swrong"
                    }
                }
            },
            "4" : {
                "_features" : "POSTTESTA/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE"
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "HalleyEd"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Sally",
        "isActive" : true,
        "lastname" : "Ride",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q6Bad" : "unchecked",
                        "q2Bad" : "unchecked",
                        "q4Bad" : "unchecked",
                        "q4Good" : "checked",
                        "q3CVS" : "CVS_WV",
                        "q2Good" : "checked",
                        "q5CVS" : "CVS_WV",
                        "q1CVS" : "SC",
                        "q6Good" : "checked"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2cmbfblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "globals" : {
                        "posttest1freeresp" : "its asking for the surface",
                        "MAX_CSBS_R2" : 2,
                        "pretest3kt_r1" : 0.9661764855363307,
                        "pretest2kt_cvlog" : 0,
                        "pretest0goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest1cvslogic" : "TYPEA",
                        "SbS1kt_r1" : 0.9999955068828859,
                        "pretest1se_text" : "To have only one part of the ramps different.",
                        "pretest0desired_outcome" : "Maximize Outcome",
                        "SbS3kt_r1" : 0.9962915738754334,
                        "pretest2kt_tov" : 0.21774193548387097,
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest0goal" : "SCIENCE",
                        "CEIC_EVAL_FB" : "EIC_EVAL_SLFEX_FB_CVSP",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0kt_cvlog" : 0,
                        "pretest1selfexp" : "PHRASE1",
                        "pretest0se_text" : "To make the balls do what I want.",
                        "pretest3kt_r0" : 0.9263537784144659,
                        "pretest2kt_vvfar" : 0.9,
                        "CEIA_IMAG_FB" : "EIC_IMAG_SLFEX_FB_CVSC",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "MAX_PSBS_R1" : 3,
                        "posttest1setup" : "Top-Top,Fim-Sif,Lof-Lof,Steep-Steep",
                        "pretest0kt_tov" : 0,
                        "pretest1kt_cvlog" : 0,
                        "pretest1kt_tov" : 0.21774193548387097,
                        "posttest2ramp" : "CVS",
                        "pretest2kt_r2" : 0.32142857142857145,
                        "pretest2selfexp" : "PHRASE10",
                        "pretest2setup" : "Top-Top,Fim-Fim,Bab-Lof,Steep-Steep",
                        "pretest0kt_vvfar" : 0,
                        "pretest0selfexp" : "PHRASE9",
                        "pretest1kt_vvfar" : 0.9,
                        "pretest2kt_r1" : 0.7499999999999999,
                        "SbS0kt_r1" : 0.9999578052717211,
                        "MAX_PSBS_R2" : 3,
                        "pretest2ramp" : "CVS",
                        "pretest3cvslogic" : "TYPEB",
                        "pretest0kt_r2" : 0,
                        "pretest3kt_cvlog" : 0.21774193548387097,
                        "pretest3goal" : "SCIENCE",
                        "posttest0ramp" : "CVS",
                        "pretest3kt_tov" : 0.7541999997703432,
                        "pretest3ramp" : "CVS",
                        "posttest0freeresp" : "i guessed\r",
                        "pretest2kt_r0" : 0.5625,
                        "pretest0kt_r1" : 0,
                        "pretest1kt_r2" : 0.32142857142857145,
                        "pretest0kt_r0" : 0,
                        "pretest1kt_r0" : 0.5625,
                        "lastSBS" : "Q2",
                        "pretest3selfexp" : "PHRASE1",
                        "posttest3freeresp" : "it asks for the steepness",
                        "pretest2desired_outcome" : "Different Outcome",
                        "SbS3kt_r2" : 0.37929861576684926,
                        "ftrfocuscorrect" : "true",
                        "pretest2goal" : "ENGINEERING",
                        "pretest3kt_vvfar" : 0.9906020982988881,
                        "posttest2freeresp" : "its asking for the ball type\r",
                        "pretest0ramp" : "SC",
                        "CEIC_CORR_FB" : "EIC_CORR_SLFEX_FB_ENGR",
                        "pretest0setup" : "Top-Middle,Sif-Sif,Lof-Lof,Steep-Not-Steep",
                        "posttest1ramp" : "CVS",
                        "SbS0kt_r0" : 0.9999059101496337,
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest3setup" : "Top-Top,Fim-Fim,Lof-Lof,Steep-Not-Steep",
                        "posttest0setup" : "Middle-Top,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest2se_text" : "To make the ball(s) roll farther / faster/ the same.",
                        "SbS3kt_r0" : 0.9916797026360296,
                        "posttest3ramp" : "CVS",
                        "pretest3se_text" : "To have only one part of the ramps different.",
                        "pretest1ramp" : "CVS",
                        "pretest1kt_r1" : 0.7499999999999999,
                        "CEIB_EVAL_FB" : "EIB_EVAL_SLFEX_FB_CVSC",
                        "SbS1kt_r2" : 0.9983223708819967,
                        "pretest3kt_r2" : 0.8363269794721407,
                        "CEIB_CORR_FB" : "EIB_CORR_SLFEX_FB_ER2",
                        "SbS0kt_r2" : 0.9841503127260885,
                        "MAX_PSBS_R0" : 3,
                        "MAX_CSBS_R01" : 1,
                        "pretest1goal" : "SCIENCE2",
                        "pretest2goal_text" : "I'm trying to make the balls roll fast/far/the same.",
                        "posttest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "SbS1kt_r0" : 0.9991932882557586
                    },
                    "ktSkills" : {
                        "rule1" : {
                            "pG" : 0.1,
                            "Bel" : 0.9999955068828859,
                            "pS" : 0.1,
                            "pL" : 0.9999956940975967,
                            "pT" : 0.041667
                        },
                        "rule_tov" : {
                            "pG" : 0.1,
                            "Bel" : 0.7541999997703432,
                            "pS" : 0.1,
                            "pL" : 0.7656707483810606,
                            "pT" : 0.046667
                        },
                        "rule_cvslog" : {
                            "pG" : 0.1,
                            "Bel" : 0.21774193548387097,
                            "pS" : 0.1,
                            "pL" : 0.24120967741935484,
                            "pT" : 0.03
                        },
                        "rule2" : {
                            "pG" : 0.1,
                            "Bel" : 0.9999816709683552,
                            "pS" : 0.1,
                            "pL" : 0.9999827707102539,
                            "pT" : 0.06
                        },
                        "rule0" : {
                            "pG" : 0.1,
                            "Bel" : 0.9991932882557586,
                            "pS" : 0.1,
                            "pL" : 0.9992309350727271,
                            "pT" : 0.046667
                        },
                        "rule_vvfar" : {
                            "pG" : 0.1,
                            "Bel" : 0.9906020982988881,
                            "pS" : 0.1,
                            "pL" : 0.9926069808624914,
                            "pT" : 0.213333
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:FTR_FB:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:MAX_PSBS_R0:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN"
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    },
                    "globals" : {
                        "q4CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q4Bad" : "checked",
                        "q6CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "Correct_Assessments" : "2",
                        "q2Good" : "checked",
                        "Correct_Designs" : "5",
                        "q2Bad" : "unchecked",
                        "q5CVS" : "CVS",
                        "q1CVS" : "CVS",
                        "q3CVS" : "CVS",
                        "q6Bad" : "checked"
                    },
                    "ktSkills" : {
    
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "Ridesa"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Robert",
        "isActive" : true,
        "lastname" : "Oppenheimer",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER",
                    "ktSkills" : {
    
                    },
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q2Bad" : "checked",
                        "q1CVS" : "MC",
                        "q3CVS" : "SC",
                        "q6Good" : "checked",
                        "q5CVS" : "MC",
                        "q4Bad" : "unchecked",
                        "q4Good" : "checked",
                        "q2CVS" : "HOTAT",
                        "q6Bad" : "checked",
                        "q6CVS" : "CVS_WV",
                        "q2Good" : "unchecked"
                    }
                }
            },
            "2" : {
                "_features" : "ted2low",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "globals" : {
                        "pretest3tv_text" : "Slopes",
                        "pretest0kt_vvfar" : 0.9,
                        "posttest0ramp" : "CVS",
                        "pretest1se_text" : "To compare a part of the ramps.",
                        "pretest3kt_r2" : 0,
                        "pretest0goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest0se_text" : "To compare everything about the ramps.",
                        "pretest0kt_tov" : 0,
                        "pretest3kt_r0" : 0.9916797026360296,
                        "pretest1ramp" : "CVS",
                        "pretest1setup" : "Top-Top,Fim-Sif,Lof-Lof,Steep-Steep",
                        "SbS1kt_r2" : 0.9978968932029776,
                        "pretest0kt_cvlog" : 0,
                        "posttest3freeresp" : "I setup my experiment like this because both slopes are different, so that will judge how the ball rolls down it. ",
                        "pretest1kt_tov" : 0.21774193548387097,
                        "posttest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "MAX_PSBS_R2" : 3,
                        "pretest2goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest3tv_sel" : "true",
                        "pretest1kt_cvlog" : 0,
                        "MAX_CSBS_R01" : 1,
                        "pretest2kt_cvlog" : 0,
                        "pretest3corrTYPE2" : "true",
                        "pretest1kt_vvfar" : 0.9906020982988881,
                        "pretest3goal" : "SCIENCE",
                        "pretest3corrTYPE1" : "true",
                        "SbS1kt_r0" : 0.9999144898855653,
                        "pretest2kt_tov" : 0.7541999997703432,
                        "pretest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Not-Steep-Steep",
                        "pretest3ramp" : "CVS",
                        "pretest2goal" : "SCIENCE",
                        "pretest1corrTYPE2" : "true",
                        "pretest2kt_vvfar" : 0.9991731195241145,
                        "posttest3ramp" : "CVS",
                        "pretest0selfexp" : "PHRASE2",
                        "pretest1corrTYPE1" : "true",
                        "SbS3kt_r0" : 0.9991124069722446,
                        "pretest2kt_r2" : 0,
                        "pretest2corrTYPE2" : "true",
                        "pretest2setup" : "Top-Top,Fim-Fim,Bab-Lof,Steep-Steep",
                        "pretest1selfexp" : "PHRASE3",
                        "SbS0kt_r2" : 0.9801970527952771,
                        "pretest1goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest3se_text" : "To compare a part of the ramps.",
                        "posttest0setup" : "Top-Middle,Sif-Sif,Lof-Lof,Steep-Steep",
                        "SbS0kt_r0" : 0.9991932882557586,
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest2kt_r0" : 0.9263537784144659,
                        "pretest2selfexp" : "PHRASE3",
                        "pretest2kt_r1" : 0.9962915738754334,
                        "SbS1kt_r1" : 0.9999999490554835,
                        "posttest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "posttest1freeresp" : "I set up my experiment like this because each ramp has 2 different surfaces on it and then the rest are the same.\r",
                        "MAX_PSBS_R1" : 3,
                        "pretest0goal" : "SCIENCE",
                        "pretest2corrTYPE1" : "true",
                        "posttest2setup" : "Top-Top,Sif-Sif,Lof-Bab,Steep-Steep",
                        "pretest1tv_text" : "Surfaces",
                        "SbS0kt_r1" : 0.9999995215645684,
                        "pretest3selfexp" : "PHRASE3",
                        "pretest3kt_tov" : 0.9671133732576165,
                        "posttest0freeresp" : "I designed my experiment like this because they are exactly the same except for the starting position",
                        "MAX_CSBS_R2" : 2,
                        "posttest1ramp" : "CVS",
                        "pretest3kt_cvlog" : 0,
                        "pretest1goal" : "SCIENCE",
                        "pretest2ramp" : "CVS",
                        "pretest3kt_vvfar" : 0.9999276826765708,
                        "pretest0ramp" : "MC",
                        "pretest2se_text" : "To compare a part of the ramps.",
                        "MAXVAL_CSBS_R2" : 1,
                        "lastSBS" : "Q2",
                        "SbS3kt_r1" : 0.9999578052717211,
                        "pretest1kt_r1" : 0.9661764855363307,
                        "posttest2freeresp" : "I setup my experiment like this because I knew that they had the same surface, slope, and starting position, and then the balls are different.\r",
                        "pretest0kt_r0" : 0,
                        "ftrfocuscorrect" : "true",
                        "pretest2corrTYPE3" : "true",
                        "posttest2ramp" : "CVS",
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest3kt_r1" : 0.9996038700437944,
                        "pretest0setup" : "Top-Middle,Sif-Fim,Bab-Lof,Steep-Not-Steep",
                        "pretest0kt_r2" : 0,
                        "MAX_PSBS_R0" : 3,
                        "pretest2tv_text" : "Balls",
                        "pretest1tv_sel" : "true",
                        "pretest1corrTYPE3" : "true",
                        "pretest1kt_r2" : 0,
                        "SbS3kt_r2" : 0.32142857142857145,
                        "pretest1kt_r0" : 0.5625,
                        "pretest2tv_sel" : "true"
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_LOWABILITY:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:MAX_PSBS_R0:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN",
                    "ktSkills" : {
                        "rule2" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999770133484478,
                            "pL" : 0.999978392547541,
                            "pT" : 0.06
                        },
                        "rule0" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999144898855653,
                            "pL" : 0.9999184803860757,
                            "pT" : 0.046667
                        },
                        "rule_tov" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9671133732576165,
                            "pL" : 0.9686480934678033,
                            "pT" : 0.046667
                        },
                        "rule_cvslog" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0,
                            "pL" : 0.03,
                            "pT" : 0.03
                        },
                        "rule1" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999999490554835,
                            "pL" : 0.9999999511781886,
                            "pT" : 0.041667
                        },
                        "rule_vvfar" : {
                            "pG" : 0.1,
                            "pS" : 0.1,
                            "Bel" : 0.9999276826765708,
                            "pL" : 0.99994311034813,
                            "pT" : 0.213333
                        }
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q1CVS" : "CVS",
                        "q2CVS" : "CVS",
                        "q4Good" : "unchecked",
                        "q6Bad" : "checked",
                        "q4CVS" : "CVS",
                        "q6Good" : "unchecked",
                        "q2Good" : "unchecked",
                        "Correct_Designs" : "6",
                        "q4Bad" : "checked",
                        "q3CVS" : "CVS",
                        "q5CVS" : "CVS",
                        "q6CVS" : "CVS",
                        "Correct_Assessments" : "3",
                        "q2Bad" : "checked"
                    },
                    "ktSkills" : {
    
                    },
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER"
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "OppenheimerRo"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Leonardo",
        "isActive" : true,
        "lastname" : "daVinci",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q6Good" : "checked",
                        "q3CVS" : "MC",
                        "q4Good" : "checked",
                        "q6Bad" : "unchecked",
                        "q1CVS" : "MC",
                        "q4Bad" : "unchecked",
                        "q2Good" : "unchecked",
                        "q2Bad" : "checked",
                        "q2CVS" : "CVS_WV",
                        "q5CVS" : "HOTAT"
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER",
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "ktSkills" : {
    
                    }
                }
            },
            "2" : {
                "_features" : "ted2cmbfblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "globals" : {
                        "posttest3ramp" : "CVS",
                        "pretest1kt_r1" : 0.7499999999999999,
                        "pretest0goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "posttest2ramp" : "CVS",
                        "pretest0kt_tov" : 0,
                        "pretest1kt_r2" : 0,
                        "posttest3freeresp" : "Everything should be the same but the slopes.",
                        "pretest3kt_cvlog" : 0,
                        "pretest0ramp" : "MC",
                        "posttest0freeresp" : "I accidentally clicked next. The experiment is wrong.",
                        "pretest1corrTYPE2" : "true",
                        "pretest3tv_text" : "Starting Positions, Slopes",
                        "pretest1kt_vvfar" : 0.9,
                        "MAX_PSBS_R0" : 4,
                        "posttest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest0kt_cvlog" : 0,
                        "SbS3kt_r2" : 0.9845843539644772,
                        "pretest1goal" : "SCIENCE2",
                        "pretest1kt_tov" : 0.21774193548387097,
                        "pretest1corrTYPE3" : "true",
                        "pretest3se_text" : "To compare a part of the ramps.",
                        "CEIB_EVAL_FB" : "EIB_EVAL_SLFEX_FB_CVSP",
                        "SbS1kt_r2" : 0.005813953488372094,
                        "pretest2selfexp" : "PHRASE9",
                        "pretest1kt_cvlog" : 0,
                        "SbS3kt_r1" : 0.9999578052717211,
                        "pretest2kt_vvfar" : 0.9,
                        "pretest0selfexp" : "PHRASE9",
                        "posttest1freeresp" : "Everything should be the same but the surface.",
                        "SbS3kt_r0" : 0.999990032654244,
                        "pretest3selfexp" : "PHRASE3",
                        "pretest1selfexp" : "PHRASE3",
                        "pretest2kt_r2" : 0,
                        "pretest3tv_sel" : "false",
                        "pretest1tv_sel" : "true",
                        "pretest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest2kt_r1" : 0.7499999999999999,
                        "pretest0goal" : "SCIENCE2",
                        "MAX_PSBS_R2" : 3,
                        "MAX_CSBS_R01" : 1,
                        "pretest3kt_r0" : 0.5625,
                        "pretest3kt_r2" : 0,
                        "SbS1kt_r1" : 0.9661764855363307,
                        "pretest2ramp" : "CVS",
                        "pretest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "MAX_CSBS_R2" : 2,
                        "pretest0desired_outcome" : "Different Outcome",
                        "pretest1tv_text" : "Surfaces",
                        "pretest3kt_tov" : 0.21774193548387097,
                        "pretest2kt_r0" : 0.5625,
                        "SbS0kt_r1" : 0.9962915738754334,
                        "pretest1ramp" : "CVS",
                        "SbS2kt_r2" : 0.8686074031405745,
                        "pretest3kt_vvfar" : 0.9906020982988881,
                        "SbS2kt_r1" : 0.9996038700437944,
                        "ftrfocuscorrect" : "true",
                        "CEIA_IMAG_FB" : "EIC_IMAG_SLFEX_FB_ENGR",
                        "MAXVAL_CSBS_R2" : 1,
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Lof,Steep-Steep",
                        "SbS0kt_r2" : 0.3866758241758242,
                        "pretest2desired_outcome" : "Different Outcome",
                        "SbS0kt_r0" : 0.9991124069722446,
                        "SbS2kt_r0" : 0.9999059101496337,
                        "SbS1kt_r0" : 0.9916797026360296,
                        "pretest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "posttest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "posttest2freeresp" : "Everything should be the same but the type of ball.",
                        "posttest0ramp" : "SC",
                        "pretest3kt_r1" : 0.7499999999999999,
                        "pretest2kt_cvlog" : 0,
                        "pretest2goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0se_text" : "To make the balls do what I want.",
                        "posttest1ramp" : "CVS",
                        "pretest3ramp" : "CVS",
                        "CEIB_CORR_FB" : "EIB_CORR_SLFEX_FB_CVSP",
                        "pretest0kt_r0" : 0,
                        "CEIC_CORR_FB" : "EIC_CORR_SLFEX_FB_ENGR",
                        "pretest2kt_tov" : 0.21774193548387097,
                        "pretest2se_text" : "To make the balls do what I want.",
                        "pretest0kt_r1" : 0,
                        "CEIC_EVAL_FB" : "EIC_EVAL_SLFEX_FB_ENGR",
                        "pretest3goal" : "SCIENCE2",
                        "pretest0setup" : "Top-Middle,Sif-Fim,Lof-Bab,Steep-Not-Steep",
                        "pretest1se_text" : "To compare a part of the ramps.",
                        "pretest0kt_r2" : 0,
                        "pretest3goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest1corrTYPE1" : "true",
                        "pretest1kt_r0" : 0.5625,
                        "pretest2goal" : "SCIENCE2",
                        "MAX_PSBS_R1" : 3,
                        "lastSBS" : "Q4",
                        "pretest0kt_vvfar" : 0
                    },
                    "ktSkills" : {
                        "rule_vvfar" : {
                            "Bel" : 0.9906020982988881,
                            "pL" : 0.9926069808624914,
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule1" : {
                            "Bel" : 0.9999578052717211,
                            "pL" : 0.9999595633994642,
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule_cvslog" : {
                            "Bel" : 0,
                            "pL" : 0.03,
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule0" : {
                            "Bel" : 0.999990032654244,
                            "pL" : 0.9999904978003684,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule2" : {
                            "Bel" : 0.9998294094255087,
                            "pL" : 0.9998396448599781,
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "pS" : 0.1
                        },
                        "rule_tov" : {
                            "Bel" : 0.21774193548387097,
                            "pL" : 0.2542475725806452,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "pS" : 0.1
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:FTR_FB:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:MAX_PSBS_R0:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN"
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    },
                    "ktSkills" : {
    
                    },
                    "globals" : {
                        "q4Bad" : "unchecked",
                        "q5CVS" : "MC",
                        "q4Good" : "checked",
                        "q2Bad" : "unchecked",
                        "q1CVS" : "MC",
                        "q6Good" : "unchecked",
                        "q6CVS" : "HOTAT",
                        "q3CVS" : "MC",
                        "q2Good" : "checked",
                        "q6Bad" : "checked",
                        "Correct_Designs" : "0",
                        "Correct_Assessments" : "1"
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER"
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "daVinciLe"
    },
    {
        "ability" : "",
        "class" : "6",
        "firstname" : "Francis",
        "isActive" : true,
        "lastname" : "Bacon",
        "mi" : "",
        "period" : "3",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q1CVS" : "MC",
                        "q4Bad" : "checked",
                        "q6Good" : "checked",
                        "q6Bad" : "unchecked",
                        "q4Good" : "unchecked",
                        "q2Bad" : "unchecked",
                        "q3CVS" : "MC",
                        "q2Good" : "checked",
                        "q4CVS" : "HOTAT",
                        "q5CVS" : "MC"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2cmblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "pretest3corrTYPE1" : "true",
                        "MAX_PSBS_R1" : 3,
                        "pretest3se_text" : "To compare a part of the ramps.",
                        "SbS0kt_r1" : 0.9999955068828859,
                        "pretest3tv_text" : "Slopes",
                        "MAX_PSBS_R0" : 3,
                        "pretest1corrTYPE1" : "true",
                        "pretest1kt_r0" : 0.5625,
                        "posttest0ramp" : "CVS",
                        "pretest1goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "SbS1kt_r1" : 0.9999995215645684,
                        "pretest2ramp" : "MC",
                        "pretest2selfexp" : "PHRASE9",
                        "pretest3kt_r1" : 0.9962915738754334,
                        "posttest3freeresp" : "the slopes are different \r",
                        "SbS1kt_r0" : 0.999990032654244,
                        "posttest1freeresp" : "the surfaces are different so nothing else  could causse it to be different",
                        "SbS3kt_r2" : 0.005813953488372094,
                        "pretest3kt_r2" : 0,
                        "pretest3kt_cvlog" : 0,
                        "SbS0kt_r2" : 0.8686074031405745,
                        "pretest1goal" : "SCIENCE2",
                        "pretest3kt_vvfar" : 0.9991731195241145,
                        "posttest1ramp" : "CVS",
                        "pretest1corrTYPE2" : "true",
                        "pretest2setup" : "Middle-Top,Fim-Sif,Lof-Bab,Not-Steep-Steep",
                        "pretest1tv_text" : "Surfaces",
                        "pretest1tv_sel" : "true",
                        "SbS0kt_r0" : 0.9999059101496337,
                        "pretest3corrTYPE2" : "true",
                        "pretest2kt_r0" : 0.5625,
                        "pretest1corrTYPE3" : "true",
                        "pretest1kt_vvfar" : 0.9906020982988881,
                        "pretest2kt_r1" : 0.9661764855363307,
                        "posttest2setup" : "Top-Top,Fim-Fim,Lof-Bab,Steep-Steep",
                        "pretest0goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "SbS3kt_r0" : 0.9916797026360296,
                        "posttest0freeresp" : "it has different starting positions like it should\r ",
                        "pretest3kt_r0" : 0.9263537784144659,
                        "pretest2kt_r2" : 0,
                        "posttest1setup" : "Top-Top,Fim-Sif,Lof-Lof,Not-Steep-Not-Steep",
                        "posttest3setup" : "Top-Top,Fim-Fim,Lof-Lof,Not-Steep-Steep",
                        "pretest3goal" : "SCIENCE2",
                        "MAX_CSBS_R2" : 2,
                        "MAX_CSBS_R01" : 1,
                        "pretest2kt_vvfar" : 0.9906020982988881,
                        "SbS3kt_r1" : 0.9996038700437944,
                        "pretest2se_text" : "To make the balls do what I want.",
                        "pretest0selfexp" : "PHRASE2",
                        "pretest1se_text" : "To see what parts of the ramps mattered.",
                        "pretest0kt_r0" : 0,
                        "ftrfocuscorrect" : "true",
                        "pretest1setup" : "Middle-Top,Sif-Fim,Bab-Lof,Steep-Not-Steep",
                        "pretest2goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest3goal_text" : "I'm trying to find out if a part of the ramps makes a difference.",
                        "MAX_PSBS_R2" : 3,
                        "pretest1kt_r2" : 0,
                        "pretest1kt_r1" : 0.9661764855363307,
                        "pretest1kt_tov" : 0.21774193548387097,
                        "posttest0setup" : "Top-Middle,Fim-Fim,Lof-Lof,Steep-Steep",
                        "pretest3tv_sel" : "true",
                        "pretest1ramp" : "MC",
                        "pretest2goal" : "SCIENCE2",
                        "pretest2desired_outcome" : "Same Outcome",
                        "pretest0kt_r2" : 0,
                        "pretest2kt_cvlog" : 0,
                        "posttest2freeresp" : "the brand of balls are different\r",
                        "pretest3selfexp" : "PHRASE3",
                        "pretest0goal" : "SCIENCE",
                        "pretest3ramp" : "MC",
                        "pretest0setup" : "Top-Middle,Fim-Sif,Lof-Bab,Steep-Not-Steep",
                        "pretest0kt_cvlog" : 0,
                        "pretest0kt_tov" : 0,
                        "pretest0kt_vvfar" : 0.9,
                        "pretest2kt_tov" : 0.21774193548387097,
                        "lastSBS" : "Q2",
                        "pretest3setup" : "Top-Middle,Sif-Fim,Bab-Lof,Not-Steep-Steep",
                        "pretest0ramp" : "MC",
                        "posttest2ramp" : "CVS",
                        "pretest1selfexp" : "PHRASE6",
                        "posttest3ramp" : "CVS",
                        "pretest0se_text" : "To compare everything about the ramps.",
                        "pretest3kt_tov" : 0.7541999997703432,
                        "MAXVAL_CSBS_R2" : 1,
                        "SbS1kt_r2" : 0.9845843539644772,
                        "pretest1kt_cvlog" : 0
                    },
                    "ktSkills" : {
                        "rule0" : {
                            "pS" : 0.1,
                            "Bel" : 0.999990032654244,
                            "pL" : 0.9999904978003684,
                            "pT" : 0.046667,
                            "pG" : 0.1
                        },
                        "rule1" : {
                            "pS" : 0.1,
                            "Bel" : 0.9999995215645684,
                            "pL" : 0.9999995414995375,
                            "pT" : 0.041667,
                            "pG" : 0.1
                        },
                        "rule2" : {
                            "pS" : 0.1,
                            "Bel" : 0.9998294094255087,
                            "pL" : 0.9998396448599781,
                            "pT" : 0.06,
                            "pG" : 0.1
                        },
                        "rule_tov" : {
                            "pS" : 0.1,
                            "Bel" : 0.7541999997703432,
                            "pL" : 0.7656707483810606,
                            "pT" : 0.046667,
                            "pG" : 0.1
                        },
                        "rule_vvfar" : {
                            "pS" : 0.1,
                            "Bel" : 0.9991731195241145,
                            "pL" : 0.9993495204166766,
                            "pT" : 0.213333,
                            "pG" : 0.1
                        },
                        "rule_cvslog" : {
                            "pS" : 0.1,
                            "Bel" : 0,
                            "pL" : 0.03,
                            "pT" : 0.03,
                            "pG" : 0.1
                        }
                    },
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:MAX_PSBS_R0:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN"
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "q4Good" : "unchecked",
                        "Correct_Designs" : "3",
                        "q4Bad" : "checked",
                        "q3CVS" : "CVS",
                        "q4CVS" : "HOTAT",
                        "q5CVS" : "CVS",
                        "q2Good" : "checked",
                        "q1CVS" : "CVS",
                        "q6Bad" : "unchecked",
                        "q6Good" : "checked",
                        "Correct_Assessments" : "1",
                        "q2Bad" : "unchecked"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_POSTTEST:FTR_TYPEB:FTR_ASSESSB:NO_ITER",
                    "sceneGraph" : {
                        "currNodeID" : "node6",
                        "currNode" : {
                            "index" : "3"
                        }
                    }
                }
            }
        },
        "study" : "TED2_SPRING2014_DR",
        "teacher" : "Archimedes",
        "userId" : "BaconFr"
    },
    {
        "firstname" : "Neil",
        "isActive" : true,
        "lastname" : "Tyson",
        "phases" : {
            "1" : {
                "_features" : "PRETESTA-DR",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "PRE-TEST",
                "progress" : "COMPLETE",
                "stateData" : {
                    "sceneGraph" : {
                        "currNode" : {
                            "index" : "0"
                        },
                        "currNodeID" : "node6"
                    },
                    "globals" : {
                        "q2Good" : "checked",
                        "q6Bad" : "unchecked",
                        "q5CVS" : "MC",
                        "q2Bad" : "unchecked",
                        "q3CVS" : "HOTAT",
                        "q4Good" : "checked",
                        "q1CVS" : "MC",
                        "q4Bad" : "unchecked",
                        "q6Good" : "checked"
                    },
                    "ktSkills" : {
    
                    },
                    "features" : "FTR_PRETEST:FTR_TYPEA:FTR_DEDRSN:NO_ITER"
                }
            },
            "2" : {
                "_features" : "ted2cmbfblow",
                "_loader" : "TED2_FALL13B_RMT",
                "_phase" : "TED-TUTOR",
                "progress" : "COMPLETE",
                "stateData" : {
                    "globals" : {
                        "pretest0selfexp" : "PHRASE6",
                        "pretest3kt_vvfar" : 0.9999276826765708,
                        "MAXVAL_CSBS_R2" : 1,
                        "pretest0kt_r1" : 0.7499999999999999,
                        "pretest1kt_cvlog" : 0,
                        "pretest3kt_r1" : 0.9996038700437944,
                        "posttest3ramp" : "SC",
                        "pretest3selfexp" : "PHRASE3",
                        "pretest2corrTYPE1" : "true",
                        "pretest2tv_sel" : "true",
                        "pretest1selfexp" : "PHRASE3",
                        "pretest0kt_r2" : 0,
                        "pretest1kt_tov" : 0.7541999997703432,
                        "pretest0tv_sel" : "false",
                        "SbS3kt_r0" : 0.9991124069722446,
                        "SbS1kt_r0" : 0.9999989441911231,
                        "posttest0ramp" : "CVS",
                        "pretest1ramp" : "CVS",
                        "pretest2kt_vvfar" : 0.9991731195241145,
                        "pretest0kt_vvfar" : 0.9,
                        "pretest3setup" : "Top-Top,Sif-Sif,Bab-Bab,Steep-Not-Steep",
                        "pretest0tv_text" : "Slopes",
                        "pretest3kt_tov" : 0.9964165910954976,
                        "pretest2tv_text" : "Balls",
                        "pretest3kt_r2" : 0,
                        "pretest2kt_tov" : 0.9671133732576165,
                        "pretest1kt_vvfar" : 0.9906020982988881,
                        "posttest0freeresp" : "Everything is the same but the starting position.",
                        "pretest1kt_r2" : 0,
                        "SbS0kt_r2" : 0.9801970527952771,
                        "pretest0ramp" : "MC",
                        "lastSBS" : "Q2",
                        "pretest0kt_tov" : 0.21774193548387097,
                        "pretest0kt_cvlog" : 0,
                        "posttest3freeresp" : "Everything is the same but the slope.",
                        "pretest1kt_r1" : 0.9661764855363307,
                        "MAX_PSBS_R1" : 3,
                        "pretest3corrTYPE1" : "true",
                        "SbS1kt_r1" : 0.9999999490554835,
                        "pretest2kt_cvlog" : 0,
                        "pretest1se_text" : "To compare a part of the ramps.",
                        "pretest2corrTYPE2" : "true",
                        "pretest1kt_r0" : 0.5625,
                        "CEIC_EVAL_FB" : "EIC_EVAL_SLFEX_FB_CVSC",
                        "pretest2goal" : "SCIENCE",
                        "posttest0setup" : "Top-Middle,Sif-Sif,Bab-Bab,Steep-Steep",
                        "pretest2ramp" : "CVS",
                        "pretest1goal" : "SCIENCE",
                        "pretest1tv_text" : "Surfaces",
                        "pretest2corrTYPE3" : "true",
                        "MAX_PSBS_R0" : 3,
                        "pretest1corrTYPE3" : "true",
                        "SbS1kt_r2" : 0.9978968932029776,
                        "CEIA_IMAG_FB" : "EIC_IMAG_SLFEX_FB_CVSC",
                        "pretest3goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest1setup" : "Top-Top,Sif-Fim,Bab-Bab,Steep-Steep",
                        "pretest2selfexp" : "PHRASE3",
                        "pretest1tv_sel" : "true",
                        "pretest2goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest3tv_sel" : "true",
                        "pretest1corrTYPE2" : "true",
                        "CEIB_EVAL_FB" : "EIB_EVAL_SLFEX_FB_OF",
                        "SbS0kt_r0" : 0.999990032654244,
                        "pretest2se_text" : "To compare a part of the ramps.",
                        "pretest3ramp" : "CVS",
                        "pretest3corrTYPE2" : "true",
                        "SbS0kt_r1" : 0.9999995215645684,
                        "posttest1setup" : "Top-Top,Fim-Sif,Lof-Lof,Steep-Steep",
                        "pretest1corrTYPE1" : "true",
                        "MAX_PSBS_R2" : 3,
                        "CEIC_CORR_FB" : "EIC_CORR_SLFEX_FB_VE",
                        "MAX_CSBS_R2" : 2,
                        "pretest2setup" : "Top-Top,Sif-Sif,Lof-Bab,Not-Steep-Not-Steep",
                        "pretest3kt_r0" : 0.9916797026360296,
                        "pretest3tv_text" : "Slopes",
                        "ftrfocuscorrect" : "true",
                        "pretest3goal" : "SCIENCE",
                        "posttest2freeresp" : "Everything is the same but the balls.",
                        "pretest3kt_cvlog" : 0,
                        "posttest3setup" : "Top-Top,Sif-Fim,Bab-Bab,Not-Steep-Steep",
                        "posttest2ramp" : "CVS",
                        "posttest1freeresp" : "Everything is the same but the surface.",
                        "posttest2setup" : "Top-Top,Sif-Sif,Bab-Lof,Steep-Steep",
                        "pretest2kt_r1" : 0.9962915738754334,
                        "posttest1ramp" : "CVS",
                        "pretest0setup" : "Top-Middle,Sif-Fim,Bab-Lof,Steep-Not-Steep",
                        "MAX_CSBS_R01" : 1,
                        "pretest0corrTYPE2" : "true",
                        "pretest3se_text" : "To compare a part of the ramps.",
                        "pretest1goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "SbS3kt_r2" : 0.32142857142857145,
                        "pretest2kt_r0" : 0.9263537784144659,
                        "pretest0goal" : "SCIENCE",
                        "CEIB_CORR_FB" : "EIB_CORR_SLFEX_FB_CVSP",
                        "pretest0se_text" : "To see what parts of the ramps mattered.",
                        "pretest0goal_text" : "I'm comparing the two ramps, or parts of them.",
                        "pretest0kt_r0" : 0,
                        "SbS3kt_r1" : 0.9999578052717211,
                        "pretest2kt_r2" : 0
                    },
                    "ktSkills" : {
                        "rule_vvfar" : {
                            "pS" : 0.1,
                            "pL" : 0.99994311034813,
                            "pT" : 0.213333,
                            "pG" : 0.1,
                            "Bel" : 0.9999276826765708
                        },
                        "rule1" : {
                            "pS" : 0.1,
                            "pL" : 0.9999999511781886,
                            "pT" : 0.041667,
                            "pG" : 0.1,
                            "Bel" : 0.9999999490554835
                        },
                        "rule_cvslog" : {
                            "pS" : 0.1,
                            "pL" : 0.03,
                            "pT" : 0.03,
                            "pG" : 0.1,
                            "Bel" : 0
                        },
                        "rule2" : {
                            "pS" : 0.1,
                            "pL" : 0.9982548491557592,
                            "pT" : 0.06,
                            "pG" : 0.1,
                            "Bel" : 0.9981434565486801
                        },
                        "rule_tov" : {
                            "pS" : 0.1,
                            "pL" : 0.996583818038844,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "Bel" : 0.9964165910954976
                        },
                        "rule0" : {
                            "pS" : 0.1,
                            "pL" : 0.9999989934625559,
                            "pT" : 0.046667,
                            "pG" : 0.1,
                            "Bel" : 0.9999989441911231
                        }
                    },
                    "features" : "DMO_ALL:FTR_RAMPSINTRO:FTR_RAMPSPRETEST:FTR_STACOM:FTR_SBYS1:FTR_SBYS2:FTR_EIA:FTR_EIB:FTR_EIC:FTR_RAMPSPOSTTEST:FTR_CMB:FTR_LOWABILITY:FTR_FB:R012_SEEN:PSBS_R0_LRN:PSBS_R1_LRN:MAX_PSBS_R0:MAX_PSBS_R1:MAX_PSBS_R2:CSBS_R2_LRN:EIB_SEEN:EIC_SEEN",
                    "sceneGraph" : {
                        "currNodeID" : "END_CLOAK",
                        "currNode" : {
                            "index" : "0"
                        }
                    }
                }
            },
            "3" : {
                "_features" : "ted2_hsCC",
                "_loader" : "TED2_HIGHSTAKES_RMT",
                "_phase" : "TED-HIGHSTAKES",
                "progress" : "COMPLETE"
            },
            "4" : {
                "_features" : "POSTTESTB/a",
                "_loader" : "STORY_FALL13_RMT",
                "_phase" : "POST-TEST",
                "progress" : "READY"
            }
        },
        "userId" : "TysonNe"
    }];
    
    classDataList.forEach(initTimeStampFields);

    classCollection.insertAll(classDataList);

    print("Class Data Collection Initialized");
    
  }
  
  print("Un-comment line to initialize DB");

  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  
  // These functions will delete collections in the TED database and reinitialize them - use with care
  
  //db.open().then((c)=>insertStudy());
  
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
  //@@@@ CAUTION @@@@@@@@@@@
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
