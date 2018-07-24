library closureSample;

import 'dart:io';
import 'dart:isolate';
import 'dart:async';


int testVal = 2;

void main()
{


  port.receive(IsolateExit);

  testVal = 10;

  testFunc(val)
  {
    var value = testVal + val;

    print(testVal + val);

    subFunc(value)
    {
      print(testVal + value);
    }

    subFunc(value);
  }

  testFunc(3);

  SendPort func1 = spawnFunction(IsolateEntry1);

  testVal = 10;

  print("Current Tval: "+ testVal.toString());

  SendPort func2 = spawnFunction(IsolateEntry2);

  func1.send(3, port.toSendPort());
  func2.send(13, port.toSendPort());
}



isolateGenerator()
{
 // testVal = 10;

  SendPort func1 = spawnFunction(IsolateEntry1);

  print("Current Tval: "+ testVal.toString());

  SendPort func2 = spawnFunction(IsolateEntry2);

  func1.send(3, port.toSendPort());
  func2.send(13, port.toSendPort());
}


/** --------------------------------------------------------------------
*
*   isolate Entry/Exit point
*
------------------------------------------------------------------------- */

SendPort IsolateEntry1()
{
  print("Isolate1 isolate Entry");

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  port.receive(IsolateProcessor1);
}


SendPort IsolateEntry2()
{
  print("Isolate2 isolate Entry");

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  port.receive(IsolateProcessor2);
}


void IsolateExit(msg, replyTo)
{
  print("Root Isolate isolate Exit");
  print("Exit Data: " + testVal.toString());

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  port.close();
}


/** --------------------------------------------------------------------
*
*   Isolate Port - callback function
*
------------------------------------------------------------------------*/

void IsolateProcessor1(msg, replyTo)
{
  print('parsing Isolate1 work package');

  var reply = "Processed Data: " + testVal.toString() + " - passed Value: " + msg.toString();

  print(reply);

  for(var i1 = 0 ; i1 < 1000 ; i1++)
                            print("AB");

  if(msg != "3")
  {
      if (reply != null && replyTo != null)
                         replyTo.send(reply);
  }
}


void IsolateProcessor2(msg, replyTo)
{
  print('parsing Isolate2 work package');

  var reply = "Processed Data: " + testVal.toString() + " - passed Value: " + msg.toString();

  print(reply);

  for(var i1 = 0 ; i1 < 1000 ; i1++)
                            print("12");

  if(msg != "3")
  {
      if (reply != null && replyTo != null)
                         replyTo.send(reply);
  }
}
