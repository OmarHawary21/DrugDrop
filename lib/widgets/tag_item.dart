import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/drug_item.dart';
import '../providers/drug_data.dart';
import '../providers/tags_provider.dart';

class TagItem extends StatelessWidget {
  static const routeName = '/tag-item';
  final String tagTitle;
  final List<Drug> drugs;
  final List<String> imagePath = [
    'assets/images/Medicine.svg',
    'assets/images/spoon and syrup.svg',
    'assets/images/cream.svg',
    'assets/images/Syringe.svg',
    'assets/images/spray-can.svg',
    'assets/images/eye-dropper.svg',
  ];

  TagItem(this.tagTitle, this.drugs);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context).size;
    //here we are getting the id of category and not for a tag
    final tagId = ModalRoute.of(context)!.settings.arguments as int;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(imagePath[tagId]),
                    const SizedBox(width: 15),
                    Text(
                      tagTitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: theme.primary,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('See all...'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => DrugItem(
                drugs[i].id,
                drugs[i].imageUrl,
                drugs[i].price.toString(),
                drugs[i].tradeName,
              ),
              itemCount: drugs.length,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
