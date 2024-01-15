import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/category_item.dart';
import '../providers/categories_provider.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<CategoriesProvider>(context).fetchCategories();
      setState(() => _isLoading = false);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final categoryData =
        Provider.of<CategoriesProvider>(context, listen: false).categories;
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Browse By Category:',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 18,
              fontFamily: 'PollerOne'
            ),
          ),
        ),
        const SizedBox(height: 10),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                ),
              )
            : categoryData.isEmpty
                ? Center(
                    child: Text(
                      'No categories to see.',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox(
                    width: width,
                    height: height * 0.35,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryData.length,
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          children: [
                            CategroyItem(
                              categoryData[i].id,
                              currentLocale.languageCode == 'en'
                                  ? categoryData[i].en_name
                                  : categoryData[i].ar_name,
                            ),
                          ],
                        ),
                      ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    ),
                  ),
      ],
    );
  }
}
