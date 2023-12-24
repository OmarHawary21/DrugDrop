import 'dart:convert';
import '../main.dart';

import '../providers/drug_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrugsProvider with ChangeNotifier {
  final String token;

  DrugsProvider(this.token);

  final List<Drug> _items = [
    Drug(
      id: 1,
      tradeName: 'tradeName',
      scientificName: 'scientificName',
      company: 'company',
      description:
          'description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test  description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test description test test test test test test test test  ',
      tagId: 1,
      dose: 10,
      doseUnit: 'doseUnit',
      price: 10,
      quantity: 10,
      expiryDate: 'expiryDate',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    // Drug(
    //   id: 'id1',
    //   tradeName: 'tradeName',
    //   scientificName: 'scientificName',
    //   company: 'company',
    //   description: 'description',
    //   tagId: 1,
    //   dose: 10,
    //   doseUnit: 'doseUnit',
    //   price: 10,
    //   quantity: 10,
    //   expiryDate: 'expiryDate',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Drug(
    //   id: 'id2',
    //   tradeName: 'tradeName',
    //   scientificName: 'scientificName',
    //   company: 'company',
    //   description: 'description',
    //   tagId: 1,
    //   dose: 10,
    //   doseUnit: 'doseUnit',
    //   price: 10,
    //   quantity: 10,
    //   expiryDate: 'expiryDate',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
  ];

  List<Drug> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Drug findDrugById(int id) {
    return _items.firstWhere((drug) => drug.id == id);
  }

  Future<void> fetchAndSetDrugs(int id) async {
    var url = Uri.http(host, '/api/drug/get/category/1', {'lang_code': 'en'});
    try {
      print('before get-------------------------------');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      print(url);
      print('$token------------------------------');
      print('after get--------------------------------');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // final List<Tag> loadedTags = [];
      final List<Drug> loadedDrugs = [];
      print('im here');

      if (extractedData == Null) {
        return;
      }
      // print(extractedData);
      // extractedData['Data'].forEach(
      //   (tagId, tagData) {
      //     print('$tagId-----------');
      //     print('$tagData--------------------');
      //   loadedTags.add(
      //     Tag(
      //       name: tagData['en_name'],
      //       id: tagId,
      //       drugs: tagData['drugs'].forEach((drugId, drugData) {
      //         loadedDrugs.add(
      //           Drug(
      //             id: drugId,
      //             tradeName: drugData['trade_name'],
      //             scientificName: drugData['scientific_name'],
      //             company: drugData['company'],
      //             tagId: drugData['tag_id'],
      //             dose: drugData['dose'],
      //             doseUnit: drugData['doseUnit'],
      //             price: drugData['price'],
      //             quantity: drugData['quantity'],
      //             expiryDate: drugData['expiryDate'],
      //             imageUrl: drugData['imageUrl'],
      //           ),
      //         );
      //       }),
      //     ),
      //   );
      // },
      // );
      // _tag = loadedTags;
      // _items = loadedDrugs;
      notifyListeners();
    } catch (error) {
      //print(error.toString());
      throw (error);
    }
  }
}
