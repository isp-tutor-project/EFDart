library streamSample1;

import 'dart:async';


void main()
{
  Stream<int> counterStream = timedCounter(const Duration(milliseconds: 40), 15);
  counterStream.listen(print);      // Print an integer every second, 15 times.
}


// NOTE: This implementation is FLAWED!
// It starts before it has subscribers, and it doesn't implement pause.

Stream<int> timedCounter(Duration interval, [int maxCount])
{
  StreamController<int> controller = new StreamController<int>();
  int counter = 0;

  void tick(Timer timer)
  {
    counter++;
    controller.add(counter); // Ask stream to send counter values as event.

    if (maxCount != null && counter >= maxCount)
    {
      timer.cancel();
      controller.close();    // Ask stream to shut down and tell listeners.
    }
  }

  new Timer.periodic(interval, tick); // BAD: Starts before it has subscribers.

  return controller.stream;
}