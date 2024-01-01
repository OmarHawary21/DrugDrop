import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/tags_screen.dart';
import '../providers/tags_provider.dart';

class CategroyItem extends StatelessWidget {
  final int id;
  final String title;
  CategroyItem(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.12,
      child: Card(
        margin: const EdgeInsets.only(
          bottom: 5,
          left: 10,
          right: 10,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorScheme.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        color: colorScheme.secondary,
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.13,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Icon(Icons.local_hospital, color: colorScheme.primary),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              // left: MediaQuery.of(context).size.width * 0.13,
              top: MediaQuery.of(context).size.height * 0.03,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(TagsScreen.routeName, arguments: id);
          },
        ),
      ),
    );
  }
}
