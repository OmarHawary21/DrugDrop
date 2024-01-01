import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/drugs_provider.dart';
import '../providers/cart_provider.dart';

class DrugCard extends StatelessWidget {
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final bool isFavorite;

  DrugCard(this.id, this.name, this.price, this.imageUrl, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context).items;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    print(isFavorite);

    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(5, 5),
              blurRadius: 15,
              spreadRadius: -2,
            ),
          ],
        ),
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  isFavorite
                      ? Provider.of<DrugsProvider>(context, listen: false)
                          .removeFromFavorites(id)
                      : Provider.of<DrugsProvider>(context, listen: false)
                          .addToFavorites(id);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: width * 0.06,
                ),
              ),
              IconButton(
                onPressed: () {
                  cartItems.forEach((element) {
                    if(element.id != id.toString()){
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(id, name, price, 1);
                    }
                    else {
                      element.quantity++;
                    }
                  });
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: primary,
                  size: width * 0.06,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              Flexible(
                flex: 6,
                child: Image.asset(
                  'assets/images/forgotPassword.png',
                  color: Colors.white.withOpacity(0.6),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 7, top: 2),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: width * 0.03,
                          color: secondary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        '$price S.P',
                        style: TextStyle(
                          fontSize: width * 0.03,
                          color: secondary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
