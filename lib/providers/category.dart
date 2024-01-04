import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  final int id;
  final String en_name;
  final String ar_name;

  Categories({
    required this.id,
    required this.en_name,
    required this.ar_name,
  });
}
