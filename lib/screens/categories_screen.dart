import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_item.dart';
import '../widgets/browse_by_category.dart';
import '../providers/tags_provider.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<TagsProvider>(context).fetchAndSetTags(1);
      setState(() => _isLoading = false);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tags = Provider.of<TagsProvider>(context).tags;

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
            ),
          )
        : ListView(
            children: [
              Category(),
              HomeItem(_isLoading, 'Newest', tags[6].drugs),
              HomeItem(_isLoading, 'Best Sellers', tags[3].drugs),
              HomeItem(_isLoading, 'Sales', tags[5].drugs),
            ],
          );
  }
}
