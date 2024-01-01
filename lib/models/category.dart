import 'package:flutter/material.dart';

import 'tag.dart';

class Categories with ChangeNotifier {
  final int id;
  final String name;
  List<Tag> tags;

  Categories({
    required this.id,
    required this.name,
    this.tags = const [],
  });
}
