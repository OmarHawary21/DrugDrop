import '../providers/cart_provider.dart';
import '../providers/drug_data.dart';

import '../providers/drugs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugDetailsScreen extends StatelessWidget {
  static const routeName = '/drug-details';
  bool isPressed = false;
//show dialog for quantity
  // void _showDialog(BuildContext context, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //       title: Center(
  //         child: Text(
  //           'Indicate Your Quantity',
  //           style: TextStyle(color: Theme.of(context).colorScheme.background),
  //         ),
  //       ),
  //       content: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           IconButton(
  //             onPressed: () {},
  //             icon: Icon(
  //               Icons.remove_circle_rounded,
  //               color: Theme.of(context).colorScheme.primary,
  //             ),
  //           ),
  //           const Text('quantity'),
  //           IconButton(
  //             onPressed: () {},
  //             icon: Icon(
  //               Icons.add_circle_rounded,
  //               color: Theme.of(context).colorScheme.primary,
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         ElevatedButton(
  //           onPressed: () {},
  //           child: const Text('Add to cart'),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // use this to add description in container
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  //this container for adding description
  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    final drugId =
        ModalRoute.of(context)!.settings.arguments as int; // is the id!
    final loadedDrug =
        Provider.of<DrugsProvider>(context, listen: false).findDrugById(drugId);
    final scaffold = ScaffoldMessenger.of(context);
    // final drug = Provider.of<Drug>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedDrug.tradeName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 300,
            child: Image.network(
              loadedDrug.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${loadedDrug.scientificName}',
                      style: TextStyle(
                          color: theme.primary,
                          fontFamily: 'PollerOne',
                          fontSize: 16),
                    ),
                    Text(
                      '${loadedDrug.price} s.p',
                      style: TextStyle(
                          color: theme.primary,
                          fontFamily: 'PollerOne',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${loadedDrug.company}',
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${loadedDrug.quantity}',
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                buildSectionTitle(context, 'Drug Description'),
                buildContainer(
                  SingleChildScrollView(
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        child: Text(loadedDrug.description),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
              loadedDrug.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.pinkAccent,
            ),
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: theme.primary,
            onPressed: () {
              cart.addToCart(
                  loadedDrug.id.toString(), loadedDrug.tradeName, loadedDrug.price.toDouble());
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(loadedDrug.id.toString());
                    },
                  ),
                ),
              );
              isPressed = !isPressed;
            },
            child: Icon(
              isPressed
                  ? Icons.shopping_cart_rounded
                  : Icons.add_shopping_cart_rounded,
              color: theme.background,
            ),
            heroTag: null,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
