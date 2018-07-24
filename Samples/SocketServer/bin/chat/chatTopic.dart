
part of chat.chatService;

class chatTopic 
{
  static const int DEFAULT_IDLE_TIMEOUT = 60 * 60 * 1000;  // One hour.
  
  chatTopic()
      : _activeUsers = new Map(),
        _messages = new List(),
        _nextMessageNumber = 0,
        _callbacks = new Map();

  int get activeUsers => _activeUsers.length;

  chatUser _userJoined(String handle) {
    chatUser user = new chatUser(handle);
    _activeUsers[user.sessionId] = user;
    chatMessage message = new chatMessage.join(user);
    _addMessage(message);
    return user;
  }

  chatUser _userLookup(String sessionId) => _activeUsers[sessionId];

  void _userLeft(String sessionId) {
    chatUser user = _userLookup(sessionId);
    chatMessage message = new chatMessage.leave(user);
    _addMessage(message);
    _activeUsers.remove(sessionId);
  }

  bool _addMessage(chatMessage message) {
    message.messageNumber = _nextMessageNumber++;
    _messages.add(message);

    // Send the new message to all polling clients.
    List messages = new List();
    messages.add(message.toMap());
    _callbacks.forEach((String sessionId, Function callback) {
      callback(messages);
    });
    _callbacks = new Map();
  }

  bool _userMessage(Map requestData) {
    String sessionId = requestData["sessionId"];
    chatUser user = _userLookup(sessionId);
    if (user == null) return false;
    String handle = user.handle;
    String messageText = requestData["message"];
    if (messageText == null) return false;

    // Add new message.
    chatMessage message = new chatMessage(user, messageText);
    _addMessage(message);
    user.markActivity();

    return true;
  }

  List messagesFrom(int messageNumber, int maxMessages) {
    if (_messages.length > messageNumber) {
      if (maxMessages != null) {
        if (_messages.length - messageNumber > maxMessages) {
          messageNumber = _messages.length - maxMessages;
        }
      }
      List messages = new List();
      for (int i = messageNumber; i < _messages.length; i++) {
        messages.add(_messages[i].toMap());
      }
      return messages;
    } else {
      return null;
    }
  }

  void registerChangeCallback(String sessionId, var callback) {
    _callbacks[sessionId] = callback;
  }

  void _handleTimer(Timer timer) {
    Set inactiveSessions = new Set();
    // Collect all sessions which have not been active for some time.
    DateTime now = new DateTime.now();
    _activeUsers.forEach((String sessionId, chatUser user) {
      if (user.idleTime(now).inMilliseconds > DEFAULT_IDLE_TIMEOUT) {
        inactiveSessions.add(sessionId);
      }
    });
    // Terminate the inactive sessions.
    inactiveSessions.forEach((String sessionId) {
      Function callback = _callbacks.remove(sessionId);
      if (callback != null) callback(null);
      chatUser user = _activeUsers.remove(sessionId);
      chatMessage message = new chatMessage.timeout(user);
      _addMessage(message);
    });
  }

  Map<String, chatUser> _activeUsers;
  List<chatMessage> _messages;
  int _nextMessageNumber;
  Map<String, Function> _callbacks;
}


