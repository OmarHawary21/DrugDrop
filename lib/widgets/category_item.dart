import 'package:flutter/material.dart';

import '../screens/tags_screen.dart';

class CategroyItem extends StatelessWidget {
  final int id;
  final String title;

  CategroyItem(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(60),
      onTap: () => Navigator.of(context).pushNamed(
        TagsScreen.routeName,
        arguments: id,
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: colorScheme.secondary,
        backgroundImage: AssetImage('assets/images/category.jpg'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
