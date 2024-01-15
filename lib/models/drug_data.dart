import 'package:flutter/foundation.dart';

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
    this.isFavorite = false,
  });
}
