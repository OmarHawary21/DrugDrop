import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import '../widgets/tag_item.dart';
import '../providers/tags_provider.dart';
import '../providers/categories_provider.dart';

class TagsScreen extends StatefulWidget {
  static const routeName = '/tags';

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final catId = ModalRoute.of(context)?.settings.arguments as int;
      _isLoading = true;
      Provider.of<TagsProvider>(context, listen: false)
          .fetchAndSetTags(catId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final catId = ModalRoute.of(context)?.settings.arguments as int;
    final catData = Provider.of<CategoriesProvider>(context).findById(catId);
    final tags = Provider.of<TagsProvider>(context, listen: false).tags;
    Locale currentLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(currentLocale.languageCode == 'en'
            ? catData.en_name
            : catData.ar_name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => TagItem(
            tags[index].id,
            currentLocale.languageCode == 'en'
                ? tags[index].en_name
                : tags[index].ar_name,
            tags[index].drugs),
        itemCount: tags.length,
      ),
    );
  }
}
