
part of chat.chatService;

class chatServerStatus 
{
  int    _state;
  String _message;
  int    _port;
  var    _error;
  
  static const STARTING = 0;
  static const STARTED = 1;
  static const STOPPING = 2;
  static const STOPPED = 3;
  static const ERROR = 4;

  chatServerStatus(this._state, this._message);
  
  chatServerStatus.starting()            : _state = STARTING;
  chatServerStatus.started(this._port)   : _state = STARTED;
  chatServerStatus.stopping()            : _state = STOPPING;
  chatServerStatus.stopped()             : _state = STOPPED;
  chatServerStatus.error2([this._error]) : _state = ERROR;

  int     get port  => _port;
  dynamic get error => _error;
  
  bool get isStarting => _state == STARTING;
  bool get isStarted  => _state == STARTED;
  bool get isStopping => _state == STOPPING;
  bool get isStopped  => _state == STOPPED;
  bool get isError    => _state == ERROR;

  int get state => _state;
  
  String get message 
  {
    if (_message != null) return _message;
    
    switch (_state) 
    {
      case STARTING: return "Server starting";
      
      case STARTED: return "Server listening";
      
      case STOPPING: return "Server stopping";
      
      case STOPPED: return "Server stopped";
      
      case ERROR:
        
        if (_error == null) 
        {
          return "Server error";
        } 
        else 
        {
          return "Server error: $_error";
        }
    }
    
  }

}


