

part of chat.chatService;

class chatServerCommand 
{
  int    _command;
  String _host;
  int    _port;
  bool   _logging;
  
  static const START = 0;
  static const STOP = 1;

  chatServerCommand.start(String this._host,
                          int this._port,
                          {bool logging: false})
      : _command = START, _logging = logging;
  
  chatServerCommand.stop() : _command = STOP;

  bool get isStart => _command == START;
  bool get isStop => _command == STOP;

  String get host => _host;
  int    get port => _port;
  bool   get logging => _logging;
}


