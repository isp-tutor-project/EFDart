

import 'dart:io';
import 'dart:async';
import 'dart:convert';

main()
{
  var config = new File('config.txt');

  singleCharInput();
}

void singleCharInput()
{

  Stream<List<int>> inputStream = stdin;

  inputStream
    .transform(new AsciiDecoder())
    .listen(
      (String line) {
        print('Read ${line.length} bytes from stream: ' + line);
      },
      onDone: () { print('file is now closed'); },
      onError: (e) { print(e.toString()); });

}


void multiCharInput()
{

  Stream<List<int>> inputStream = stdin;

  inputStream
    .transform(new AsciiDecoder())
    .transform(new LineSplitter())
    .listen(
      (String line) {
        print('Read ${line.length} bytes from stream: ' + line);
      },
      onDone: () { print('file is now closed'); },
      onError: (e) { print(e.toString()); });

}