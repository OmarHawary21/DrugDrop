import 'dart:convert';
import '../main.dart';

import '../providers/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider with ChangeNotifier {
  List<Categories> _categories = [
    // Categories(id: 0, name: 'Antibiotics'),
    // Categories(id: 1, name: 'Antibiotics'),
    // Categories(id: 2, name: 'Antibiotics'),
    // Categories(id: 3, name: 'Antibiotics'),
    // Categories(id: 4, name: 'Antibiotics'),
    // Categories(id: 5, name: 'Antibiotics'),
    // Categories(id: 6, name: 'Antibiotics'),
    // Categories(id: 7, name: 'Antibiotics'),
    // Categories(id: 8, name: 'Heart'),
    // Categories(id: 9, name: 'Antibiotics'),
    // {'name': 'Antibiotics', 'icon': Icons.local_hospital},
    // {'name': 'Analgesics', 'icon': Icons.local_hospital},
    // {'name': 'Psychiatric and Neurological', 'icon': Icons.local_hospital},
    // {'name': 'Hormonal', 'icon': Icons.local_hospital},
    // {'name': 'Diabetes', 'icon': Icons.local_hospital},
    // {'name': 'Heart', 'icon': Icons.local_hospital},
    // {'name': 'Respiratory', 'icon': Icons.local_hospital},
    // {'name': 'Gastrointestinal', 'icon': Icons.local_hospital},
    // {'name': 'Nutritional', 'icon': Icons.local_hospital},
    // {'name': 'Cosmetics', 'icon': Icons.local_hospital},
  ];

  List<Categories> get categories {
    return [..._categories];
  }

  Categories findById(int id) {
    return _categories.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchCategories() async {
    var url = Uri.http(host, '/api/category/get');
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer 90|lRH4RSmMeMkCdakhlR55Blo8uPS0fsmqGc4NPOUw0237fd66'
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Categories> loadedCategories = [];
      if (extractedData == Null) {
        return;
      }
      extractedData['Data'].forEach((index) {
        loadedCategories.add(Categories(
          id: index['id'],
          name: index['en_name'],
        ));
      });
      _categories = loadedCategories;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      //throw (error);
    }
  }
}
