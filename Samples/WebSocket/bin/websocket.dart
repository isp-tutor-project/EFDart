// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dartiverse_search;

import 'dart:async';
import 'dart:convert';
import 'dart:io';


/**
 * Handle an established [WebSocket] connection.
 *
 * The web-socket can send search requests as JSON-formatted messages,
 * that will be responded to with a series of results and finally a done
 * message.
 */
void handleWebSocket(WebSocket webSocket)
{
  print('New web-socket connection');

  // Listen for incoming data. We expect the data to be a JSON-encoded String.
  webSocket
    .map((string) => JSON.decode(string))
    .listen((json) {
      // The JSON object should contains a 'request' entry.
      var request = json['request'];
      switch (request) {
        case 'search':
          // Initiate a new search.
          var input = json['input'];
          print("Searching for '$input'");
          int done = 0;
          break;

        default:
          print("Invalid request '$request'.");
      }
    }, onError: (error) {
      print('Bad WebSocket requester $error');
    });
}

/**
 * Handle an established [HTTP] connection.
 *
 * The web-socket can send search requests as JSON-formatted messages,
 * that will be responded to with a series of results and finally a done
 * message.
 */
void handleHTTPSocket(Socket socket)
{
  print('New web-socket connection');

  // Listen for incoming data. We expect the data to be a JSON-encoded String.
  socket
    .map((string) => JSON.decode(string))
    .listen((json) {
      // The JSON object should contains a 'request' entry.
      var request = json['request'];
      switch (request) {
        case 'search':
          // Initiate a new search.
          var input = json['input'];
          print("Searching for '$input'");
          int done = 0;
          break;

        default:
          print("Invalid request '$request'.");
      }
    }, onError: (error) {
      print('Bad HTTP request $error');
    });
}


void main()
{

  var webRoot = Platform.script.resolve('../bin/webroot').toFilePath();

  int port = 80;

  // The client will connect using a WebSocket. Upgrade requests to '/ws' and
  // forward them to 'handleWebSocket'.

  HttpServer.bind(InternetAddress.ANY_IP_V6, port).then((server)
  {
    print("WebSocket Server is running on "
             "'http://${Platform.localHostname}:$port/'");

      server.transform(new WebSocketTransformer()).listen(handleWebSocket, onError: (error) {
        print('Bad WebSocket request $error');
      });

      //server.listen(handleHTTPSocket);

  });
}
