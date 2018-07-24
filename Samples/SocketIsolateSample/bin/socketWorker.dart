//
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

part of socketisolatesample;


class socketWorker
{
  Socket            _xactSocket;

  socketWorker.onConnect(Socket socket)
  {
    _xactSocket = socket;

    print('socketWorker: ${_xactSocket.encoding}');

    _xactSocket.write('Socket Started');

    _xactSocket.transform(UTF8.decoder).listen(processClientMessage, onError:errorManager, onDone:doneManager);
//    _xactSocket.listen(processClientMessage, onError:errorManager, onDone:doneManager);

    print('socketWorker: Transaction Socket Open:');
  }


  void errorManager(message)
  {
    print('socketWorker: Transaction Socket Error:');

    _xactSocket.close();
  }


  void doneManager()
  {
    print('socketWorker: Transaction Socket Closed:');

    _xactSocket.close();
  }


  void processClientMessage(message)
  {

   // String str = new String.fromCharCodes(message);

//    print('socketWorker: ${str}');
//
//    _xactSocket.write(str);
//
//    String str2 = "message-ack";
//
//    print('socketWorker: ${str2}');
//
//    _xactSocket.write(str2);

    print('socketWorker: ${_xactSocket.encoding}');

    print('socketWorker: ${message}');

    print('socketWorker: ${message.runtimeType.toString()}');

    message = '<policy-file-request/>\x00';

    _xactSocket.write(message);


   try
   {
     if(message.startsWith('<policy-file-request/>'))
                      print("message matches literal");
   }
   catch(err)
   {
     print("Type missmatch: $err");
   }

//
//    String str2 = message;
//           str2 = '<policy-file-request/>';
//
//    print('socketWorker: ${str2}');
//
//    print('socketWorker: ${str2.runtimeType.toString()}');
//
//    _xactSocket.write(str2);

  }

}






