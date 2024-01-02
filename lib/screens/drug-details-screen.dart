import '../providers/cart_provider.dart';
import '../providers/drug_data.dart';

import '../providers/drugs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugDetailsScreen extends StatefulWidget {
  static const routeName = '/drug-details';

  @override
  State<DrugDetailsScreen> createState() => _DrugDetailsScreenState();
}

class _DrugDetailsScreenState extends State<DrugDetailsScreen> {
  bool isPressed = false;
  int _quantityCounter = 0;
  void _incrementQuantity() {
    setState(() {
      _quantityCounter++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      _quantityCounter--;
    });
  }

//show dialog for quantity
  void _showDialog(BuildContext context, String content) {
    final loadedDrug = Provider.of<DrugsProvider>(context, listen: false).item;
    final cart = Provider.of<CartProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'Indicate Your Quantity',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (_quantityCounter > 0) {
                  _decrementQuantity();
                }
              },
              icon: Icon(
                Icons.remove_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text('$_quantityCounter'),
            IconButton(
              onPressed: () {
                if (_quantityCounter < loadedDrug.quantity!) {
                  _incrementQuantity();
                }
              },
              icon: Icon(
                Icons.add_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              cart.addToCart(loadedDrug.id!, loadedDrug.tradeName!,
                  loadedDrug.price!, _quantityCounter);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {
                _quantityCounter = 0;
              });
            },
            child: const Text('Add to cart'),
          )
        ],
      ),
    );
  }

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
    final loadedDrug = Provider.of<DrugsProvider>(context, listen: false).item;
    print(loadedDrug.id);
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    print(loadedDrug.imageUrl);
    final scaffold = ScaffoldMessenger.of(context);
    // final drug = Provider.of<Drug>(context, listen: false);
    print('asaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${loadedDrug.imageUrl}');
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedDrug.tradeName!),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: media.height * 0.4,
              child: loadedDrug.imageUrl == 'null'
                  ? Image.asset('assets/images/Medical prescription-rafiki.png')
                  : Image.network(
                      'http://192.168.43.239/${loadedDrug.imageUrl}',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loadedDrug.scientificName}',
                        style: TextStyle(
                            color: theme.primary,
                            fontFamily: 'PollerOne',
                            fontSize: 16),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: theme.secondary,
                        ),
                        child: Text(
                          'Price: ${loadedDrug.price} s.p',
                          style: TextStyle(
                              color: theme.primary,
                              fontFamily: 'PollerOne',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loadedDrug.company}',
                        style: TextStyle(
                            color: theme.primary,
                            fontFamily: 'PollerOne',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: theme.secondary,
                        ),
                        child: Text(
                          'Quantity: ${loadedDrug.quantity} ',
                          style: TextStyle(
                              color: theme.primary,
                              fontFamily: 'PollerOne',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
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
                        child: Text(loadedDrug.description!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
              _showDialog(context, 'text');

              // isPressed = !isPressed;
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
