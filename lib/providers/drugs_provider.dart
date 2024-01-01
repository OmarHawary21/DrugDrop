import 'dart:convert';
import '../main.dart';

import '../providers/drug_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrugsProvider with ChangeNotifier {
  final String token;

  DrugsProvider(this.token);

  List<Drug> _items = [];
  List<Drug> _favoriteItems = [];

  List<Drug> get items {
    return [..._items];
  }

  List<Drug> get favoriteItems{
    return [..._favoriteItems];
  }

  Drug findDrugById(int id) {
    return _items.firstWhere((drug) => drug.id == id);
  }

  Future<void> fetchDrugs() async {
    final url = Uri.http(host, '/api/drug/get', {'lang_code': 'en'});
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final data = json.decode(response.body);
    final drugs = data['Data'] as List<dynamic>;
    final List<Drug> temp = [];
    drugs.forEach((drug) {
      temp.add(
        Drug(
          id: drug['id'],
          tradeName: drug['trade_name'],
          scientificName: drug['scientific_name'],
          company: drug['company'],
          tagId: drug['tag_id'],
          dose: drug['dose'],
          doseUnit: drug['dose_unit'],
          price: drug['price'],
          quantity: drug['quantitiy'],
          expiryDate: drug['expiry_date'],
          imageUrl: drug['img_url'].toString(),
        ),
      );
      _items = temp;
    });
  }

  Future<void> fetchFavorites() async {
    final url = Uri.http(host, '/api/favorite/get', {'lang_code': 'en'});
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final data = json.decode(response.body);
    final drugs = data['Data'] as List<dynamic>;
    final List<Drug> temp = [];
    drugs.forEach((drug) {
      temp.add(
        Drug(
          id: drug['id'],
          tradeName: drug['trade_name'],
          scientificName: drug['scientific_name'],
          company: drug['company'],
          tagId: drug['tag_id'],
          dose: drug['dose'],
          doseUnit: drug['dose_unit'],
          price: drug['price'],
          quantity: drug['quantitiy'],
          expiryDate: drug['expiry_date'],
          imageUrl: drug['img_url'].toString(),
          isFavorite: true,
        ),
      );
      _favoriteItems = temp;
    });
  }

  Future<void> addToFavorites(int id) async {
    final url = Uri.http(host, '/api/favorite/add/$id', {'lang_code': 'en'});

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final data = json.decode(response.body);
    final responseData = data['Status'];
    if (responseData == 'Success') {
      final editedDrug = findDrugById(id);
      editedDrug.isFavorite = true;
      _favoriteItems.add(editedDrug);
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(int id) async {
    final url = Uri.http(host, '/api/favorite/delete/$id', {'lang_code': 'en'});

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final data = json.decode(response.body);
    final responseData = data['Status'];
    if (responseData == 'Success') {
      _favoriteItems.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}
