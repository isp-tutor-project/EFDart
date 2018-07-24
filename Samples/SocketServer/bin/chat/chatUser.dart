
part of chat.chatService;

class chatUser 
{
  static int nextSessionId = 0;

  chatUser(this._handle) 
  {
    _sessionId = "a${nextSessionId++}";
    markActivity();
  }

  void markActivity() { _lastActive = new DateTime.now(); }
  
  Duration idleTime(DateTime now) => now.difference(_lastActive);

  String get handle => _handle;
  String get sessionId => _sessionId;

  String _handle;
  String _sessionId;
  DateTime _lastActive;
}


