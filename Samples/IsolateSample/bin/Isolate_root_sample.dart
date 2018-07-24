
import "dart:isolate";

int testVal = 2;


ReceivePort rootMonitorPort;

void main()
{
  rootMonitorPort = new ReceivePort();
  rootMonitorPort.listen(IsolateExit);

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

  testFunc(20);

  // The root monitor port keeps the root isolate alive

  rootMonitorPort.sendPort.send("exit");
}


void IsolateExit(msg)
{
  print("Root Isolate Exit");
  print("Exit Data: " + testVal.toString());

  // Note: If you do not add a callback to the default isolate receive port
  //       the isolate will terminate immediately

  rootMonitorPort.close();
}

