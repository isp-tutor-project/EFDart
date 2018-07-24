
part of chat.chatService;

class chatMessage 
{
  chatUser _from;
  DateTime _received;
  int      _type;
  String   _message;
  int      _messageNumber;

  static const int JOIN = 0;
  static const int MESSAGE = 1;
  static const int LEAVE = 2;
  static const int TIMEOUT = 3;
  static const List<String> _typeName = const [ "join", "message", "leave", "timeout"];

  chatMessage.join(this._from)
      : _received = new DateTime.now(), _type = JOIN;
  
  chatMessage(this._from, this._message)
      : _received = new DateTime.now(), _type = MESSAGE;
  
  chatMessage.leave(this._from)
      : _received = new DateTime.now(), _type = LEAVE;
  
  chatMessage.timeout(this._from)
      : _received = new DateTime.now(), _type = TIMEOUT;

  chatUser get from     => _from;
  DateTime get received => _received;
  String   get message  => _message;
  void     set messageNumber(int n) { _messageNumber = n; }

  Map toMap() 
  {
    Map map = new Map();
    
    map["from"]     = _from.handle;
    map["received"] = _received.toString();
    map["type"]     = _typeName[_type];
    
    if (_type == MESSAGE) map["message"] = _message;
    
    map["number"] = _messageNumber;
    
    return map;
  }

}


