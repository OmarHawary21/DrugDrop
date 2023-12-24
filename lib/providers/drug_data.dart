import 'dart:convert';
import '../main.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Drug with ChangeNotifier {
  final int id;
  final String tradeName;
  final String scientificName;
  final String company;
  final String description;
  final int tagId;
  final int dose;
  final String doseUnit;
  final int price;
  final int quantity;
  final String expiryDate;
  final String imageUrl;
  bool isFavorite;
  Drug({
    required this.id,
    required this.tradeName,
    required this.scientificName,
    required this.company,
    this.description = '',
    required this.tagId,
    required this.dose,
    required this.doseUnit,
    required this.price,
    required this.quantity,
    required this.expiryDate,
    required this.imageUrl,
    this.isFavorite = true,
  });

  void _setFavStatus(bool newFavStatus) {
    isFavorite = newFavStatus;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    var url = Uri.https(host, '/products/$id.json');
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.patch(
        url,
        body: json.encode({'isFavorite': isFavorite}),
      );
      if (response.statusCode >= 400) {
        _setFavStatus(oldStatus);
        // throw HttpException('Could not added to favorites!');
      }
    } catch (error) {
      _setFavStatus(oldStatus);
    }
  }
}
