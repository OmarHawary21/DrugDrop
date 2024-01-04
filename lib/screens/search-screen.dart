import 'package:drug_drop2/main.dart';
import 'package:drug_drop2/providers/drugs_provider.dart';
import 'package:drug_drop2/providers/tags_provider.dart';
import 'package:drug_drop2/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search-provider.dart';

import '/screens/drug-details-screen.dart';
import '/widgets/category_item.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final Map<String, String> searchData = {
  'type': '',
  'value': '',
  'category': '',
};

class _SearchScreenState extends State<SearchScreen> {
  List<String> searching = [
    'Category',
    'Medicine',
  ];
  var _isLoading = false;
  void _showDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        content: TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          style: TextStyle(
              fontFamily: 'poppins',
              color: Theme.of(context).colorScheme.primary),
          showCursor: true,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                  width: 0.8, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          onChanged: (text) {
            searchData['category'] = text.toString();
          },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  updateData(searchData['type']!, searchData['value']!,
                      searchData['category']!);
                  Navigator.pop(context);
                },
                child: Text(LocaleKeys.search_imperative.tr()),
              ),
            ],
          )
        ],
      ),
    );
  }

  void updateData(String type, String value, String cat) async {
    if (type == '') {
      print('can\'t search you must choose the type of search');
    }

    setState(() => _isLoading = true);
    try {
      //here I will get the result of search
      Provider.of<SearchProvider>(context, listen: false)
          .getResult(type, value, cat)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context).size;
    final searchResult = Provider.of<SearchProvider>(context);
    var categories = searchResult.searchedCategories;
    var medicines = searchResult.searchedDrugs;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: media.width * 0.03,
            vertical: media.height * 0.01,
          ),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            style: TextStyle(fontFamily: 'poppins', color: theme.primary),
            showCursor: true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list_alt),
                  onPressed: () {
                    _showDialog(context, LocaleKeys.search_for_category.tr());
                  }),
              isDense: true,
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(width: 0.8, color: theme.primary),
              ),
              hintText: LocaleKeys.search_medicine_or_category.tr(),
              prefixIcon: Icon(
                Icons.search,
                size: 30.0,
              ),
              prefixIconColor: theme.primary,
            ),
            onChanged: (text) {
              searchData['value'] = text.toString();
              updateData(searchData['type']!, searchData['value']!,
                  searchData['category']!);
            },
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: searching
                .map(
                  (category) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      selectedColor: theme.background.withOpacity(0.4),
                      backgroundColor: Colors.blueGrey.withOpacity(0.2),
                      label: Text(category),
                      selected: searchData['type']!.contains(category),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            searchData['type'] = category;
                          } else {
                            searchData['type'] = '';
                          }
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: media.height * 0.02),
        Expanded(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (medicines.length == 0 && categories.length == 0)
                  ? Center(
                      child: Text(LocaleKeys.no_such_item.tr()),
                    )
                  : searchData['type'] == LocaleKeys.category.tr()
                      ? ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<TagsProvider>(context,
                                          listen: false)
                                      .fetchAndSetTags(categories[i].id);
                                },
                                child: CategroyItem(
                                  categories[i].id,
                                  currentLocale.languageCode == 'en'
                                      ? categories[i].en_name
                                      : categories[i].ar_name,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: medicines.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  medicines[index].tradeName!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primary,
                                  ),
                                ),
                                subtitle: Text(
                                  '${medicines[index].price}',
                                  style: TextStyle(
                                    color: theme.primary,
                                  ),
                                ),
                                leading: medicines[index].imageUrl == 'null'
                                    ? Image.asset(
                                        'assets/images/Medical prescription-rafiki.png')
                                    : Image.network(
                                        'http://${host}/${medicines[index].imageUrl}',
                                        fit: BoxFit.cover,
                                      ),
                                onTap: () async {
                                  await Provider.of<DrugsProvider>(context,
                                          listen: false)
                                      .fetchDrug(medicines[index].id!);
                                  Navigator.of(context).pushNamed(
                                    DrugDetailsScreen.routeName,
                                    arguments: medicines[index].id,
                                  );
                                },
                              ),
                              Divider()
                            ],
                          ),
                        ),
        )
      ],
    );
  }
}
