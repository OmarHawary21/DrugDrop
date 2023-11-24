import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
  final String name;
  final int phoneNumber;
  final int password;
  final String location;
  User({
      required this.id,
      required this.name,
      required this.password,
      required this.phoneNumber,
      required this.location,
      });
}
