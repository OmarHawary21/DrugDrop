import 'dart:convert';
import '../main.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Drug with ChangeNotifier {
  int? id;
  String? tradeName;
  String? scientificName;
  String? company;
  String? description;
  int? tagId;
  int? dose;
  String? doseUnit;
  int? price;
  int? quantity;
  String? expiryDate;
  String? imageUrl;
  bool isFavorite;
  Drug({
    this.id,
    this.tradeName,
    this.scientificName,
    this.company,
    this.description = '',
    this.tagId,
    this.dose,
    this.doseUnit,
    this.price,
    this.quantity,
    this.expiryDate,
    this.imageUrl,
    this.isFavorite = true,
  });

  void _setFavStatus(bool newFavStatus) {
    isFavorite = newFavStatus;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    var url = Uri.http(host, '/products/$id.json');
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
