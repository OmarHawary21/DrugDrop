import 'package:drugdrop/providers/category.dart';
import 'package:flutter/material.dart';

class SearchItem with ChangeNotifier {
  String? title;
  String? imageUrl;
  double? price;
  Categories? cat;
  SearchItem({this.imageUrl, this.title, this.price, this.cat});
}
