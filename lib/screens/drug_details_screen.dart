import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/drugs_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/tags_provider.dart';

class DrugDetailsScreen extends StatefulWidget {
  static const routeName = '/drug-details';

  @override
  State<DrugDetailsScreen> createState() => _DrugDetailsScreenState();
}

class _DrugDetailsScreenState extends State<DrugDetailsScreen> {
  bool isPressed = false;

//show dialog for quantity
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.background,
          fontWeight: FontWeight.bold,
        ),
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
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    final drugId = ModalRoute.of(context)!.settings.arguments as int;
    final loadedDrug =
        Provider.of<TagsProvider>(context, listen: false).findDrugById(drugId);
    final scaffold = ScaffoldMessenger.of(context);
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedDrug.tradeName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
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
                        child: Text(
                          loadedDrug.description,
                        ),
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
            onPressed: () {
              loadedDrug.isFavorite
                  ? Provider.of<DrugsProvider>(context)
                      .removeFromFavorites(loadedDrug.id)
                  : Provider.of<DrugsProvider>(context)
                      .addToFavorites(loadedDrug.id);
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
                loadedDrug.id,
                loadedDrug.tradeName,
                loadedDrug.price,
                loadedDrug.quantity,
              );
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
