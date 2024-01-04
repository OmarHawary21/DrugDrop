import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import '../providers/categories_provider.dart';
import '/widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CategoriesProvider>(context, listen: false)
          .fetchCategories()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<CategoriesProvider>(context, listen: false)
        .fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final categoryData =
        Provider.of<CategoriesProvider>(context, listen: false).categories;
    var colorScheme = Theme.of(context).colorScheme;
    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: FadeInRight(
        duration: const Duration(milliseconds: 400),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: categoryData.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    CategroyItem(
                      categoryData[i].id,
                      currentLocale.languageCode == 'en'
                          ? categoryData[i].en_name
                          : categoryData[i].ar_name,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
