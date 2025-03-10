import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService with WidgetsBindingObserver {
  static final _instance = ChatWebService._internal();

  factory ChatWebService() => _instance;

  //private constructor
  ChatWebService._internal(); //this prevents class to be instantiated externally
  WebSocket? _socket;

  final _searchResultController = StreamController<
      Map<String, dynamic>>.broadcast(); //to control the url that is coming
  final _contentController = StreamController<
      Map<String, dynamic>>.broadcast(); // to control the content

  //getter function for stream controllers , as we can use them publicly and get values for them , otherwise anyone will control them

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchResultController.stream;
  Stream<Map<String, dynamic>> get contentResultStream =>
      _contentController.stream;

  void connect() {
    if (_socket != null) return;
    _socket = WebSocket(
      Uri.parse("ws://localhost:8000/ws/chat"),
    );
    _socket!.messages.listen((message) {
      final data = jsonDecode(message);
      if (data['type'] == 'search_result') {
        _searchResultController.add(data);
      } else if (data['type'] == 'content') {
        _contentController.add(data);
      }
    });
  }

  void chat(String query) {
    _socket!.send(
      jsonEncode(
        {'query': query},
      ),
    );
  }

  void disconnect() {
    _socket?.close(); // Close WebSocket
    _socket = null; // Reset instance
    _searchResultController.add({}); // Clear search results
    _contentController.add({}); // Clear content
    print("WebSocket connection closed");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      disconnect(); // Close WebSocket when app is minimized or closed
    }
  }
}
