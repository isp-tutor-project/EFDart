library streamSample1;

import 'dart:core';
import 'dart:async';

// Note that it only traverses the stream once.  see output.

main()
{
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream
  var stream2= new StreamController.broadcast();  // create the stream

  stream = new Stream.fromIterable([1,2,3,4,5]);

  stream2.add("test *********");
  //stream2.stream.listen((data) {print(data);});

  stream2.stream.length.then((length)
      {
        print("**** STREAM Length:" + length.toString());
      });

//  stream2.stream.isEmpty.then((flag)
//      {
//        print("stream2 isEmpty:" + flag.toString());
//      });

  stream.toList().then((list) => print(list));

  stream.toList().then((data)
                        {
                          data.forEach((element) => print(element));
                        });

  stream.drain((value)
      {
        print("Drained: $value");  // onData handler
      });

  stream.listen((value)
  {
    print("Received: $value");  // onData handler
  });                           //

  stream
  .where((value) => value % 2 == 0) // divisible by 2
    .listen((value) => print("where: $value"));

  stream.first.then((value) => print("stream.first: $value"));  // 1

  stream.last.then((value) => print("stream.last: $value"));  // 5

  stream.isEmpty.then((value) => print("stream.isEmpty: $value"));  // false

  stream.length.then((value) => print("stream.length: $value"));  // 5
  // subscribe to the streams events


  stream.first.then((value) => print("stream.firstB: $value"));  // 1

  stream.last.then((value) => print("stream.lastB: $value"));  // 5

  stream
  .where((value) => value % 2 == 0) // divisible by 2
    .listen((value) => print("whereB: $value"));


}