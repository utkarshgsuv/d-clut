import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService with WidgetsBindingObserver {
  static final _instance = ChatWebService._internal();
  factory ChatWebService() => _instance;

  ChatWebService._internal(); // Prevents external instantiation

  WebSocket? _socket;
  Timer? _reconnectTimer; // Timer for auto-reconnect
  Timer? _pingTimer; // Timer for keep-alive pings

  final _searchResultController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _contentController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchResultController.stream;
  Stream<Map<String, dynamic>> get contentResultStream =>
      _contentController.stream;

  void connect() {
    if (_socket != null) return;

    _socket = WebSocket(Uri.parse("ws://localhost:8000/ws/chat"));

    _socket!.messages.listen(
      (message) {
        final data = jsonDecode(message);
        if (data['type'] == 'search_result') {
          _searchResultController.add(data);
        } else if (data['type'] == 'content') {
          _contentController.add(data);
        }
      },
      onDone: _handleReconnect, // Reconnect if connection closes
      onError: (error) {
        print("WebSocket Error: $error");
        _handleReconnect();
      },
    );

    _startKeepAlive(); // Start keep-alive pings
  }

  void chat(String query) {
    if (_socket != null) {
      _socket!.send(jsonEncode({'query': query}));
    } else {
      print("WebSocket not connected. Reconnecting...");
      connect();
    }
  }

  void disconnect() {
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    _socket?.close();
    _socket = null;

    _searchResultController.add({});
    _contentController.add({});

    print("WebSocket connection closed and streams cleared");
  }

  void _handleReconnect() {
    print("WebSocket disconnected. Attempting to reconnect in 5 seconds...");
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: 5), connect);
  }

  void _startKeepAlive() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(Duration(seconds: 30), (_) {
      if (_socket != null) {
        _socket!.send(jsonEncode({'type': 'ping'})); // Keep WebSocket active
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      disconnect();
    }
  }
}
