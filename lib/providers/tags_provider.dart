import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'drug_data.dart';
import '../main.dart';
import '../models/tag.dart';
import '../data/data.dart' as dummy;

class TagsProvider with ChangeNotifier {
  final String token;

  TagsProvider(this.token);

  List<Tag> _tags = [];
  List<Drug> _drugs = [];

  List<Tag> get tags {
    return [..._tags];
  }

  Drug findDrugById(int id) {
    return _drugs.firstWhere((element) => element.id == id);
  }

  Tag findTagById(String id) {
    return _tags.firstWhere((tag) => tag.id.toString() == id);
  }

  Future<void> fetchAndSetTags(int id) async {
    var url = Uri.http(host, '/api/drug/get/category/$id', {'lang_code': 'en'});
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Tag> loadedTags = [];
      extractedData['Data'].forEach(
        (tagData) {
          int tempID = tagData['id'];
          String tempName = tagData['en_name'];
          final List<Drug> tempDrug = [];
          for (var drugData in tagData['drugs']) {
            tempDrug.add(Drug(
                id: drugData['id'],
                tradeName: drugData['trade_name'],
                scientificName: drugData['scientific_name'],
                company: drugData['company'],
                tagId: drugData['tag_id'],
                dose: drugData['dose'],
                doseUnit: drugData['dose_unit'],
                price: drugData['price'],
                quantity: drugData['quantitiy'],
                expiryDate: drugData['expiryDate'].toString(),
                imageUrl: 'test',
                isFavorite: drugData['is_favorite']));
          }
          loadedTags.add(Tag(id: tempID, name: tempName, drugs: tempDrug));
        },
      );
      _tags = loadedTags;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchTagDrugs(int id) async {
    final url =
        Uri.parse('http://$host/api/drug/get/category/tag/$id?lang_code=en');

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final data = json.decode(response.body);
    final responseData = data['Data'] as List<dynamic>;
    final List<Drug> temp = [];
    responseData.forEach((drug) {
      temp.add(Drug(
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
      ));
    });
    _drugs = temp;
    print(_drugs);
  }
}
