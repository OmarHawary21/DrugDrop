import 'package:flutter/material.dart';

import 'drug_item.dart';

class DrugList extends StatelessWidget {
  const DrugList({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      height: media.height * 0.2,
      width: media.width,
      alignment: Alignment.center,
      child: ListView(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        children: [
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          DrugItem(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_right,
                ),
                alignment: Alignment.bottomCenter,
                color: theme.colorScheme.primary,
              ),
              Text(
                'See More',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: theme.colorScheme.primary,),
              )
            ],
          )
        ],
      ),
    );
  }
}
