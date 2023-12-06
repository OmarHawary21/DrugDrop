import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  final int id;
  final String name;
  // List<Object> tags = [
  //   {
  //     'tag': '',
  //     'data': [{}]
  //   }
  // ];
  // final Icon icon;
  Categories({
    required this.id,
    required this.name,
    // required this.tags,
    // required this.icon,
  });
}
