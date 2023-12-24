import '../providers/drug_data.dart';
import '../screens/drug-details-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugItem extends StatelessWidget {
  int id;
  String imageUrl;
  String price;
  String tradeName;

  DrugItem(this.id, this.imageUrl, this.price, this.tradeName);

  @override
  Widget build(BuildContext context) {
    print('hiiiiiiiiiiiiiiiiiiiiii DrugItem');
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    final scaffold = ScaffoldMessenger.of(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.secondary,
      ),
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                DrugDetailsScreen.routeName,
                arguments: id,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: media.width * 0.01,
                  vertical: media.height * 0.005),
              child: Image.asset(
                'assets/images/forgotPassword.png',
                height: media.height * 0.1,
                width: 120,
              ),
            ),
          ),
          Text(
            '$price S.P',
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
