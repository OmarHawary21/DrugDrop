import 'package:drugdrop/providers/drugs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drug_item.dart';

class DrugList extends StatelessWidget {
  const DrugList({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    final drugdata = Provider.of<DrugsProvider>(context);
    final products = drugdata.items;
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 10),
      //margin: EdgeInsets.all(0),
      height: media.height * 0.23,
      width: media.width,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i],
          child: DrugItem(),
        ),

        scrollDirection: Axis.horizontal,
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       IconButton(
        //         onPressed: () {},
        //         icon: const Icon(
        //           Icons.chevron_right,
        //         ),
        //         alignment: Alignment.bottomCenter,
        //         color: theme.colorScheme.primary,
        //       ),
        //       Text(
        //         'See More',
        //         style: TextStyle(
        //           fontFamily: 'Poppins',
        //           fontSize: 14,
        //           color: theme.colorScheme.primary,
        //         ),
        //       )
        //    ],
        //)
        //],
      ),
    );
  }
}
