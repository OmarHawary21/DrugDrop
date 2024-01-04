import 'dart:convert';
import '../main.dart';

import '../providers/drug_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrugsProvider with ChangeNotifier {
  final String token;

  DrugsProvider(this.token);

  var _item = Drug(
      // id: 1,
      // tradeName: 'tradeName',
      // scientificName: 'scientificName',
      // company: 'company',
      // description: 'description',
      // tagId: 1,
      // dose: 10,
      // doseUnit: 'doseUnit',
      // price: 10,
      // quantity: 10,
      // expiryDate: 'expiryDate',
      // imageUrl: 'null'
      );

  List<Drug> _favoriteItems = [];

//this should take another look
  Drug findDrugById(int id) {
    return _item;
  }

  Drug get item {
    return _item;
  }

  List<Drug> get favoriteItems {
    return [..._favoriteItems];
  }

  Future<void> fetchDrug(int id) async {
    var url = Uri.http(host, '/api/drug/get/$id', {'lang_code': 'ar'});
    try {
      print('before get-------------------------------');
      final response = await http.get(url, headers: {
        // 'ngrok-skip-browser-warning': '1',
        // 'content-type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization':
            'Bearer 1|RcIInMNgjhllOGmcNyuDBEepf5LoSieeLsI7gDtha05d41a6'
      });
      print(url);
      final extractedData =
          (json.decode(response.body) as Map<String, dynamic>)['Data'];
      print(extractedData);
      Drug loadedDrug;
      print('im here');

      if (extractedData == Null) {
        return;
      }
      loadedDrug = Drug(
          id: extractedData['id'],
          tradeName: extractedData['trade_name'],
          scientificName: extractedData['scientific_name'],
          company: extractedData['company'],
          tagId: extractedData['tag_id'],
          dose: extractedData['dose'],
          doseUnit: extractedData['doseUnit'],
          price: extractedData['price'],
          quantity: extractedData['quantity'],
          expiryDate: extractedData['expiryDate'],
          imageUrl: extractedData['img_url'] ?? 'null',
          description: extractedData['description']);
      _item = loadedDrug;
      notifyListeners();
    } catch (error) {
      //print(error.toString());
      throw (error);
    }
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
          quantity: drug['quantity'],
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
