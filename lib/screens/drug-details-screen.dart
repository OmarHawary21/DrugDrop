import 'package:drugdrop/providers/drug_data.dart';

import '../providers/drugs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugDetailsScreen extends StatelessWidget {
  static const routeName = '/drug-detail';
  //use this to add description in container
  // Widget buildSectionTitle(BuildContext context, String text) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 10),
  //     child: Text(
  //       text,
  //       style: Theme.of(context).textTheme.titleLarge,
  //     ),
  //   );
  // }

  // //this container for adding description
  // Widget buildContainer(Widget child) {
  //   return Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey),
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       margin: const EdgeInsets.all(10),
  //       padding: const EdgeInsets.all(10),
  //       height: 200,
  //       width: 300,
  //       child: child);
  // }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    final drugId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!
    final loadedDrug =
        Provider.of<DrugsProvider>(context, listen: false).findById(drugId);
    final scaffold = ScaffoldMessenger.of(context);
    // final drug = Provider.of<Drug>(context, listen: false);
    //final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedDrug.tradeName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedDrug.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${loadedDrug.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedDrug.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            backgroundColor: theme.primary,
            onPressed: () async {
              try {
                await Provider.of<Drug>(context, listen: false)
                    .toggleFavoriteStatus();
              } catch (error) {
                scaffold.showSnackBar(SnackBar(
                  content: Text(
                    'Could not added to favorite!',
                    textAlign: TextAlign.center,
                  ),
                ));
              }
            },
            child: Icon(
              // drug.isFavorite ? Icons.favorite :
              Icons.favorite_border,
            ),
          ),
          FloatingActionButton(
            backgroundColor: theme.primary,
            onPressed: () {
              // cart.addItem(drug.id, drug.price, drug.tradeName);
              // ScaffoldMessenger.of(context).hideCurrentSnackBar();
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       'Added item to cart!',
              //     ),
              //     duration: Duration(seconds: 2),
              //     action: SnackBarAction(
              //       label: 'UNDO',
              //       onPressed: () {
              //         cart.removeSingleItem(drug.id);
              //},
              //),
              // ),
              // );
            },
            child: Icon(
              Icons.add_shopping_cart_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
