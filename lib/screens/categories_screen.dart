import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'category_drugs_screen.dart';
import '../providers/categories_provider.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/home';

  final List<Map<String, dynamic>> categories = CategoriesProvider().categories;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: categories
              .map(
                (cat) => GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(CategoryDrugsScreen.routeName);
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Card(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                        left: 10,
                        right: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorScheme.primary),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color:  const Color.fromRGBO(219, 243, 250, 1),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.13,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              cat['icon'],
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cat['name'],
                              style: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
