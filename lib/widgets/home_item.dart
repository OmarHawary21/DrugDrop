import 'package:drug_drop/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'drug_item.dart';
import '../models/drug_data.dart';

class HomeItem extends StatefulWidget {
  static const routeName = '/tag-item';

  bool isLoading;
  final String title;
  final List<Drug> drugs;

  HomeItem(this.isLoading, this.title, this.drugs);

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: theme.primary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('${LocaleKeys.see_all.tr()}...'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: widget.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) => DrugItem(
                      widget.drugs[i].id,
                      widget.drugs[i].imageUrl,
                      widget.drugs[i].price,
                      widget.drugs[i].quantity,
                      widget.drugs[i].tradeName,
                      widget.drugs[i].isFavorite,
                    ),
                    itemCount: widget.drugs.length,
                  ),
          ),
        ],
      ),
    );
  }
}
