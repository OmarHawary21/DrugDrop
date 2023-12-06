import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';

  String get token {
    if (_token.isNotEmpty){
      return _token;
    }
    return '';
  }

  bool get isAuth {
    return token.isNotEmpty;
  }

  Future<void> login(String phoneNumber, String password) async {
    final url = Uri.parse('http://$host/api/user/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'phone_number': '09$phoneNumber',
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData == null) {
        throw Exception();
      }
      print(responseData);
      if (responseData['Status'] == 'Failed') {
        throw Exception('Failed');
      }
      _token = responseData['Data']['token'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String name, String phoneNumber, String location, String password) async {
    final url = Uri.parse('http://$host/api/user/create');
    try {
      final response = await http.put(
        url,
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'name': name,
          'phone_number': '09$phoneNumber',
          'location': location,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData == null) {
        throw Exception();
      }
      if (responseData['Status'] == 'Failed') {
        throw Exception('Failed');
      }
      _token = responseData['Data']['token'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
  
  Future<void> forgotPassword(String phoneNumber) async {
    final url = Uri.parse('http://$host/api/user/create');
  }
}
