import '../providers/drug_data.dart';
import '../screens/drug-details-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    final scaffold = ScaffoldMessenger.of(context);
    final drug = Provider.of<Drug>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                DrugDetailsScreen.routeName,
                arguments: drug.id,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: media.width * 0.01,
                  vertical: media.height * 0.005),
              child: Image.network(
                drug.imageUrl,
                fit: BoxFit.cover,
                height: 120,
                width: 120,
              ),
            ),
          ),
          Text(
            '${drug.price} S.P',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.amberAccent),
          ),
          //SizedBox(height: media.height * 0.001),
          Text(
            drug.tradeName,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: theme.colorScheme.primary),
          )
        ],
      ),
    );
  }
}
