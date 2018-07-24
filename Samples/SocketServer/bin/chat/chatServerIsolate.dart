

part of chat.chatService;

// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class chatServerIsolate 
{
  String     _host;
  int        _port;
  HttpServer _server;  // HTTP server instance.
  bool       _logRequests;

  chatTopic  _topic;
  Timer      _cleanupTimer;
  Timer      _loggingTimer;
  DateTime   _serverStart;

  bool       _logging;
  int        _messageCount;
  chatRate   _messageRate;

  // Static HTML.
  List<int> _redirectPage;
  List<int> _notFoundPage;
  
  static const String redirectPageHtml = """
            <html>
            <head><title>Welcome to the dart server</title></head>
            <body><h1>Redirecting to the front page...</h1></body>
            </html>""";
              static const String notFoundPageHtml = """
            <html><head>
            <title>404 Not Found</title>
            </head><body>
            <h1>Not Found</h1>
            <p>The requested URL was not found on this server.</p>
            </body></html>""";

  void _sendJSONResponse(HttpResponse response, Map responseData) 
  {
    response.headers.set("Content-Type", "application/json; charset=UTF-8");
    response.write(json.stringify(responseData));
    response.close();
  }

  void redirectPageHandler(HttpRequest request,
                           HttpResponse response,
                           String redirectPath) 
  {
    if (_redirectPage == null) 
    {
      _redirectPage = redirectPageHtml.codeUnits;
    }
    
    response.statusCode = HttpStatus.FOUND;
    
    response.headers.set("Location", "http://$_host:$_port/${redirectPath}");    
    response.contentLength = _redirectPage.length;
    response.add(_redirectPage);
    response.close();
  }

  // Serve the content of a file.
  void fileHandler(
      HttpRequest request, HttpResponse response, [String fileName = null]) 
  {
    final int BUFFER_SIZE = 4096;
    
    if (fileName == null) {
      fileName = request.uri.path.substring(1);
    }
    
    File file = new File(fileName);
    
    if (file.existsSync()) 
    {
      String mimeType = "text/html; charset=UTF-8";
      int lastDot = fileName.lastIndexOf(".", fileName.length);
      
      if (lastDot != -1) 
      {
        String extension = fileName.substring(lastDot);
        if (extension == ".css") { mimeType = "text/css"; }
        if (extension == ".js") { mimeType = "application/javascript"; }
        if (extension == ".ico") { mimeType = "image/vnd.microsoft.icon"; }
        if (extension == ".png") { mimeType = "image/png"; }
      }
      
      response.headers.set("Content-Type", mimeType);
      
      // Get the length of the file for setting the Content-Length header.
      
      RandomAccessFile openedFile = file.openSync();
      response.contentLength = openedFile.lengthSync();
      openedFile.closeSync();
      
      // Pipe the file content into the response.
      
      file.openRead().pipe(response);
    } 
    else 
    {
      print("File not found: $fileName");
      _notFoundHandler(request, response);
    }
  }

  // Serve the not found page.
  void _notFoundHandler(HttpRequest request, HttpResponse response) 
  {
    if (_notFoundPage == null) 
    {
      _notFoundPage = notFoundPageHtml.codeUnits;
    }
    
    response.statusCode = HttpStatus.NOT_FOUND;
    response.headers.set("Content-Type", "text/html; charset=UTF-8");
    response.contentLength = _notFoundPage.length;
    response.add(_notFoundPage);
    response.close();
  }

  // Unexpected protocol data.
  void _protocolError(HttpRequest request, HttpResponse response) 
  {
    response.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    response.contentLength = 0;
    response.close();
  }

  // Join request:
  // { "request": "join",
  //   "handle": <handle> }
  void _joinHandler(HttpRequest request, HttpResponse response) 
  {
    StringBuffer body = new StringBuffer();
    request.listen(
      (data) => body.write(new String.fromCharCodes(data)),
      onDone: () {
        String data = body.toString();
        if (data != null) {
          var requestData = json.parse(data);
          if (requestData["request"] == "join") {
            String handle = requestData["handle"];
            if (handle != null) {
              // New user joining.
              chatUser user = _topic._userJoined(handle);

              // Send response.
              Map responseData = new Map();
              responseData["response"] = "join";
              responseData["sessionId"] = user.sessionId;
              _sendJSONResponse(response, responseData);
            } else {
              _protocolError(request, response);
            }
          } else {
            _protocolError(request, response);
          }
        } else {
          _protocolError(request, response);
        }
      });
  }

  // Leave request:
  // { "request": "leave",
  //   "sessionId": <sessionId> }
  void _leaveHandler(HttpRequest request, HttpResponse response) 
  {
    StringBuffer body = new StringBuffer();
    request.listen(
      (data) => body.write(new String.fromCharCodes(data)),
      onDone: () {
        String data = body.toString();
        var requestData = json.parse(data);
        if (requestData["request"] == "leave") {
          String sessionId = requestData["sessionId"];
          if (sessionId != null) {
            // User leaving.
            _topic._userLeft(sessionId);

            // Send response.
            Map responseData = new Map();
            responseData["response"] = "leave";
            _sendJSONResponse(response, responseData);
          } else {
            _protocolError(request, response);
          }
        } else {
          _protocolError(request, response);
        }
      });
  }

  // Message request:
  // { "request": "message",
  //   "sessionId": <sessionId>,
  //   "message": <message> }
  void _messageHandler(HttpRequest request, HttpResponse response) 
  {
    StringBuffer body = new StringBuffer();
    request.listen(
      (data) => body.write(new String.fromCharCodes(data)),
      onDone: () {
        String data = body.toString();
        _messageCount++;
        _messageRate.record(1);
        var requestData = json.parse(data);
        if (requestData["request"] == "message") {
          String sessionId = requestData["sessionId"];
          if (sessionId != null) {
            // New message from user.
            bool success = _topic._userMessage(requestData);

            // Send response.
            if (success) {
              Map responseData = new Map();
              responseData["response"] = "message";
              _sendJSONResponse(response, responseData);
            } else {
              _protocolError(request, response);
            }
          } else {
            _protocolError(request, response);
          }
        } else {
          _protocolError(request, response);
        }
      });
  }

  // Receive request:
  // { "request": "receive",
  //   "sessionId": <sessionId>,
  //   "nextMessage": <nextMessage>,
  //   "maxMessages": <maxMesssages> }
  void _receiveHandler(HttpRequest request, HttpResponse response) 
  {
    StringBuffer body = new StringBuffer();
    request.listen(
      (data) => body.write(new String.fromCharCodes(data)),
      onDone: () {
        String data = body.toString();
        var requestData = json.parse(data);
        if (requestData["request"] == "receive") {
          String sessionId = requestData["sessionId"];
          int nextMessage = requestData["nextMessage"];
          int maxMessages = requestData["maxMessages"];
          if (sessionId != null && nextMessage != null) {

            void sendResponse(messages) {
              // Send response.
              Map responseData = new Map();
              responseData["response"] = "receive";
              if (messages != null) {
                responseData["messages"] = messages;
                responseData["activeUsers"] = _topic.activeUsers;
                responseData["upTime"] =
                    new DateTime.now().difference(_serverStart).inMilliseconds;
              } else {
                responseData["disconnect"] = true;
              }
              _sendJSONResponse(response, responseData);
            }

            // Receive request from user.
            List messages = _topic.messagesFrom(nextMessage, maxMessages);
            if (messages == null) {
              _topic.registerChangeCallback(sessionId, sendResponse);
            } else {
              sendResponse(messages);
            }

          } else {
            _protocolError(request, response);
          }
        } else {
          _protocolError(request, response);
        }
      });
  }

  void init() 
  {
    _logRequests = false;
    _topic = new chatTopic();
    _serverStart = new DateTime.now();
    _messageCount = 0;
    _messageRate = new chatRate();

    // Start a timer for cleanup events.
    _cleanupTimer = new Timer.periodic(const Duration(seconds: 10),
                                       _topic._handleTimer);
  }

  // Start timer for periodic logging.
  void _handleLogging(Timer timer) 
  {
    if (_logging) {
      print("${_messageRate.rate} messages/s "
            "(total $_messageCount messages)");
    }
  }

  void dispatch(chatServerCommand message, SendPort replyTo) 
  {
    if (message.isStart) 
    {
      _host = message.host;
      _port = message.port;
      _logging = message.logging;
      
      replyTo.send(new chatServerStatus.starting(), null);
      
      var handlers = {};
      
      void addRequestHandler(String path, Function handler) 
      {
        handlers[path] = handler;
      }
      
      addRequestHandler("/", (request, response) {
        redirectPageHandler(request, response, "dart_client/index.html");
      });
      addRequestHandler("/js_client/index.html", fileHandler);
      addRequestHandler("/js_client/code.js", fileHandler);
      addRequestHandler("/dart_client/index.html", fileHandler);
      addRequestHandler("/out.js", fileHandler);
      
      addRequestHandler("/favicon.ico", (request, response) {
        fileHandler(request, response, "static/favicon.ico");
      });
      
      addRequestHandler("/join", _joinHandler);
      addRequestHandler("/leave", _leaveHandler);
      addRequestHandler("/message", _messageHandler);
      addRequestHandler("/receive", _receiveHandler);
      
      HttpServer.bind(_host, _port)
          .then((s) {
            _server = s;
            _server.listen((request) {
              if (handlers.containsKey(request.uri.path)) {
                handlers[request.uri.path](request, request.response);
              } else {
                _notFoundHandler(request, request.response);
              }
            });
            replyTo.send(new chatServerStatus.started(_server.port), null);
            _loggingTimer =
                new Timer.periodic(const Duration(seconds: 1), _handleLogging);
          })
          .catchError((e) {
            replyTo.send(new chatServerStatus.error2(e.toString()), null);
          });
    }
    
    else if (message.isStop) 
    {
      replyTo.send(new chatServerStatus.stopping(), null);
      stop();
      replyTo.send(new chatServerStatus.stopped(), null);
    }
  }

  stop() {
    _server.close();
    _cleanupTimer.cancel();
    port.close();
  }

}

