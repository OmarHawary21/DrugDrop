import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import '../widgets/tag_item.dart';
import '../providers/tags_provider.dart';
import '../providers/categories_provider.dart';

class TagsScreen extends StatefulWidget {
  static const routeName = '/tags';
  int id;
  TagsScreen(this.id);

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  @override
  void didChangeDependencies() {
    // Provider.of<TagsProvider>(context).fetchAndSetDrugs(widget.id);
    // super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print('hello TAgss Screen ');
    final catId = ModalRoute.of(context)?.settings.arguments as int;
    // print('$catId???????????????');
    final catData = Provider.of<CategoriesProvider>(context).findById(catId);
    final tags = Provider.of<TagsProvider>(context, listen: false).tags;
    // print(tags[0].ID);
    // print(tags[0].name);
    // print(tags[0].drugs);
    return Scaffold(
      appBar: AppBar(
        title: Text(catData.name),
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
        itemBuilder: (_, index) => TagItem(tags[index].name, tags[index].drugs),
        itemCount: tags.length,
      ),
    );
  }
}
