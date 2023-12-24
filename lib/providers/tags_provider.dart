import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'drug_data.dart';

class TagsProvider with ChangeNotifier {
  final String token;

  TagsProvider(this.token);

  List<Tag> _tags = [
    Tag(
      ID: 1,
      name: 'pills',
      drugs: [
        Drug(
            id: 1,
            tradeName: 'tradeName',
            scientificName: 'scientificName',
            company: 'company',
            description: 'description',
            tagId: 1,
            dose: 10,
            doseUnit: 'doseUnit',
            price: 10,
            quantity: 10,
            expiryDate: 'expiryDate',
            imageUrl:
                'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
        Drug(
            id: 2,
            tradeName: 'tradeName',
            scientificName: 'scientificName',
            company: 'company',
            description: 'description',
            tagId: 1,
            dose: 10,
            doseUnit: 'doseUnit',
            price: 10,
            quantity: 10,
            expiryDate: 'expiryDate',
            imageUrl:
                'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
        Drug(
            id: 3,
            tradeName: 'cytamol',
            scientificName: 'scientificName',
            company: 'company',
            description: 'description',
            tagId: 1,
            dose: 10,
            doseUnit: 'doseUnit',
            price: 10,
            quantity: 10,
            expiryDate: 'expiryDate',
            imageUrl:
                'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
        Drug(
            id: 4,
            tradeName: 'tradeName',
            scientificName: 'scientificName',
            company: 'company',
            description: 'description',
            tagId: 1,
            dose: 10,
            doseUnit: 'doseUnit',
            price: 10,
            quantity: 10,
            expiryDate: 'expiryDate',
            imageUrl:
                'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
      ],
    ),
    // Tag(
    //   ID: 2,
    //   name: 'drinks',
    //   drugs: [
    //     Drug(
    //         id: 'id0',
    //         tradeName: 'tradeName',
    //         scientificName: 'scientificName',
    //         company: 'company',
    //         description: 'description',
    //         tagId: 1,
    //         dose: 10,
    //         doseUnit: 'doseUnit',
    //         price: 10,
    //         quantity: 10,
    //         expiryDate: 'expiryDate',
    //         imageUrl:
    //             'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
    //     Drug(
    //         id: 'id1',
    //         tradeName: 'tradeName',
    //         scientificName: 'scientificName',
    //         company: 'company',
    //         description: 'description',
    //         tagId: 1,
    //         dose: 10,
    //         doseUnit: 'doseUnit',
    //         price: 10,
    //         quantity: 10,
    //         expiryDate: 'expiryDate',
    //         imageUrl:
    //             'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
    //     Drug(
    //         id: 'id2',
    //         tradeName: 'tradeName',
    //         scientificName: 'scientificName',
    //         company: 'company',
    //         description: 'description',
    //         tagId: 1,
    //         dose: 10,
    //         doseUnit: 'doseUnit',
    //         price: 10,
    //         quantity: 10,
    //         expiryDate: 'expiryDate',
    //         imageUrl:
    //             'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
    //     Drug(
    //       id: 'id3',
    //       tradeName: 'tradeName',
    //       scientificName: 'scientificName',
    //       company: 'company',
    //       description: 'description',
    //       tagId: 1,
    //       dose: 10,
    //       doseUnit: 'doseUnit',
    //       price: 10,
    //       quantity: 10,
    //       expiryDate: 'expiryDate',
    //       imageUrl:
    //           'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     ),
    //   ],
    // ),
    // Tag(
    //   ID: 1,
    //   name: 'pills',
    //   drugs: [
    //     Drug(
    //       id: 'id0',
    //       tradeName: 'tradeName',
    //       scientificName: 'scientificName',
    //       company: 'company',
    //       description: 'description',
    //       tagId: 1,
    //       dose: 10,
    //       doseUnit: 'doseUnit',
    //       price: 10,
    //       quantity: 10,
    //       expiryDate: 'expiryDate',
    //       imageUrl:
    //           'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     ),
    //     Drug(
    //       id: 'id1',
    //       tradeName: 'tradeName',
    //       scientificName: 'scientificName',
    //       company: 'company',
    //       description: 'description',
    //       tagId: 1,
    //       dose: 10,
    //       doseUnit: 'doseUnit',
    //       price: 10,
    //       quantity: 10,
    //       expiryDate: 'expiryDate',
    //       imageUrl:
    //           'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     ),
    //     Drug(
    //       id: 'id2',
    //       tradeName: 'tradeName',
    //       scientificName: 'scientificName',
    //       company: 'company',
    //       description: 'description',
    //       tagId: 1,
    //       dose: 10,
    //       doseUnit: 'doseUnit',
    //       price: 10,
    //       quantity: 10,
    //       expiryDate: 'expiryDate',
    //       imageUrl:
    //           'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     ),
    //   ],
    // ),
    // Tag(
    //   ID: 1,
    //   name: 'pills',
    //   drugs: [
    //     Drug(
    //         id: 'id0',
    //         tradeName: 'tradeName',
    //         scientificName: 'scientificName',
    //         company: 'company',
    //         description: 'description',
    //         tagId: 1,
    //         dose: 10,
    //         doseUnit: 'doseUnit',
    //         price: 10,
    //         quantity: 10,
    //         expiryDate: 'expiryDate',
    //         imageUrl:
    //             'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
    //     Drug(
    //       id: 'id1',
    //       tradeName: 'tradeName',
    //       scientificName: 'scientificName',
    //       company: 'company',
    //       description: 'description',
    //       tagId: 1,
    //       dose: 10,
    //       doseUnit: 'doseUnit',
    //       price: 10,
    //       quantity: 10,
    //       expiryDate: 'expiryDate',
    //       imageUrl:
    //           'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     ),
    //   ],
    // ),
  ];

  List<Tag> get tags {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._tags];
  }

  Tag findTagById(String id) {
    return _tags.firstWhere((tag) => tag.ID == id);
  }

  Future<void> fetchAndSetDrugs(int id) async {
    var url = Uri.http(host, '/api/drug/get/category/$id', {'lang_code': 'en'});
    // print('$url iiiiiiiiiiiiiiiiiiiiiiiii');
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer 98|JL4maZ3IsxhgnZ5hf0k8gHBMAHIX9DGGurpFXs8P17df5095'
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(extractedData);
      if (extractedData == Null) {
        // print('nullllllllllllllllll');
        return;
      }
      final List<Tag> loadedTags = [];
      List<Drug> loadedDrugs = [];
      // print(extractedData);
      extractedData['Data'].forEach(
        (tagData) {
          int tempID = tagData['id'];
          String tempName = tagData['en_name'];
          List<Drug> tempDrug = [];
          print(tagData['drugs']);
          for (var drugData in tagData['drugs']) {
            print('im in for loop');
            // print(drugData);
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
            ));
          }
          loadedTags.add(Tag(ID: tempID, name: tempName, drugs: tempDrug));
          // print('$tagId-----------');
        },
      );
      // print(loadedTags);
      _tags = loadedTags;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class Tag {
  final int ID;
  final String name;
  List<Drug> drugs;

  Tag({required this.ID, required this.name, required this.drugs});
}
