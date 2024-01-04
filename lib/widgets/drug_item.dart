import '/main.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../providers/drugs_provider.dart';

import '../providers/drug_data.dart';
import '../screens/drug-details-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugItem extends StatelessWidget {
  int id;
  String? imageUrl = '';
  String price;
  String tradeName;

  DrugItem(this.id, this.imageUrl, this.price, this.tradeName);

  @override
  Widget build(BuildContext context) {
    //print('hiiiiiiiiiiiiiiiiiiiiii DrugItem');
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    final scaffold = ScaffoldMessenger.of(context);
    Drug drug;
    //print(imageUrl);
    return Container(
      decoration: BoxDecoration(
          //shape: BoxShape.circle,
          //color: theme.colorScheme.secondary,
          ),
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              // print('bfore fetching');
              await Provider.of<DrugsProvider>(context, listen: false)
                  .fetchDrug(id);
              drug = Provider.of<DrugsProvider>(context, listen: false).item;
              //print('${drug.id} before navigation------------');
              Navigator.of(context).pushNamed(
                DrugDetailsScreen.routeName,
                arguments: drug.id,
              );
              // print(' ${drug}after navigations+++++++++++++++++++');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: media.width * 0.002,
                  vertical: media.height * 0.002),
              child: imageUrl == 'null'
                  ? CircleAvatar(
                      backgroundColor: theme.colorScheme.secondary,
                      radius: media.height * 0.06,
                      backgroundImage: AssetImage(
                        'assets/images/forgotPassword.png',
                      ))
                  : CircleAvatar(
                      backgroundColor: theme.colorScheme.secondary,
                      radius: media.height * 0.06,
                      backgroundImage: NetworkImage(
                        'http://${host}/${imageUrl}',
                      ),
                    ),
            ),
          ),
          Text(
            '$price ${LocaleKeys.sp.tr()}',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: theme.colorScheme.primary),
          ),
          //SizedBox(height: media.height * 0.001),
          Text(
            tradeName,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
