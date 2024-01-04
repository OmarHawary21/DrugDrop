import 'package:drug_drop2/main.dart';
import 'package:drug_drop2/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  String _auth = '';
  String _channelName = '';

  String get auth {
    return _auth;
  }

  String get channleName {
    return _channelName;
  }

  List<NotificationModel> get notifications {
    return [..._notifications];
  }

  Future<void> broadcastAuth(String socketId, String channel, String token,
      WebSocketChannel webChannel) async {
    print('${socketId}+++++++++++++++++++++++++++++++++++++++++++++++++');
    print(channel);
    var url = Uri.http(host, '/api/broadcasting/auth');
    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    }, body: {
      'socket_id': socketId,
      'channel_name': channel
    });
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    _auth = extractedData['Data']['token'];
    _channelName = extractedData['Data']['channel_name'];
    webChannel.sink.add(jsonEncode({
      "event": "pusher:subscribe",
      "data": {"channel": _channelName, "auth": _auth}
    }));
    print('$_auth-------------------------');
    print('$_channelName');
  }

  Future<void> getNotification(String token) async {
    var url = Uri.http(host, '/api/notification/get');
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer 95|6H02dQIVG7hEdqYU2vMFALoB0S6ycMwsyDxbYfdSb18c2872'
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      final List<NotificationModel> loadedNotifications = [];
      if (extractedData == Null) {
        return;
      }
      extractedData['Data'].forEach((index) {
        loadedNotifications.add(NotificationModel(
            title: index['event_name'],
            message: index['message'],
            date: index['created_at']));
      });
      _notifications = loadedNotifications;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      //throw (error);
    }
  }
  
}
