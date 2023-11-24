import 'package:flutter/material.dart';

class DrugItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final drug = Provider.of<Drug>(context, listen: false);
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blueGrey.withOpacity(0.2),
            child: const Text(
              'Drug Image',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Drug Name',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: theme.colorScheme.primary),
          )
        ],
      ),
    );
  }
}
