import '../providers/search-provider.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static List<SearchItem> medicines = [
    SearchItem(
        imageUrl: 'assets/images/Medical prescription-rafiki.png',
        price: 23,
        title: 'taghreed'),
    SearchItem(
        imageUrl: 'assets/images/Medical prescription-rafiki.png',
        price: 23,
        title: 'taghreed'),
    SearchItem(
        imageUrl: 'assets/images/Medical prescription-rafiki.png',
        price: 23,
        title: 'Nour')
  ];
  List<SearchItem> filteredMedicines = List.from(medicines);
  void updateList(String value) {
    setState(() {
      filteredMedicines = medicines
          .where((medTitle) =>
              medTitle.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: media.width * 0.03,
            vertical: media.height * 0.03,
          ),
          child: TextField(
            onChanged: (value) => updateList(value),
            style: TextStyle(fontFamily: 'poppins', color: theme.primary),
            showCursor: true,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(width: 0.8, color: theme.primary),
              ),
              hintText: 'Search Medicine or Category',
              prefixIcon: Icon(
                Icons.search,
                size: 30.0,
              ),
              prefixIconColor: theme.primary,
            ),
          ),
        ),
        SizedBox(
          height: media.height * 0.02,
        ),
        Expanded(
            child: filteredMedicines.length == 0
                ? Center(
                    child: Text('No Such Medicine'),
                  )
                : ListView.builder(
                    itemCount: medicines.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                          title: Text(
                            medicines[index].title!,
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
                          trailing: Text(
                            '${medicines[index].price}',
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),
                          leading: Image.asset(medicines[index].imageUrl!),
                        ),
                        Divider()
                      ],
                    ),
                  ))
      ],
    );
  }
}
