
part of SocketServer;

class transactionSocket
{
  Socket xactSocket;

  transactionSocket.onConnect(Socket socket)
  {
    print('new connection: $socket');

    xactSocket = socket;

    xactSocket.listen(onMessage);

    connection = socket;
  }

  void onError(message)
  {
    listener.close();

    print('SocketServer Error...');
  }

  void onDone()
  {
    connection.close();

    print('Exiting SocketServer...');
  }

  void onMessage(message)
  {
    String str = new String.fromCharCodes(message);

    print('new message: $str on socket: $xactSocket');
    
    //List<int> reply = "testreply".codeUnits;
    
    xactSocket.write("testreply\x00");
  }
}