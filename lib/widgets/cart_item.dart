import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(
    this.id,
    this.productId,
    this.title,
    this.price,
    this.quantity,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.colorScheme.error,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: theme.colorScheme.secondary,
            icon: Icon(
              Icons.delete,
              color: theme.colorScheme.error,
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            title: const Text('Are you sure?'),
            content: const Text('This will delete this item from the cart'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('NO'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('YES'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => Provider.of<CartProvider>(
        context,
        listen: false,
      ).removeItem(productId),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: theme.colorScheme.secondary,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              radius: 25,
              child: const FittedBox(
                child: Text('Drug Image'),
              ),
            ),
            title: Text(title),
            subtitle: Text('Price for one: $price (S.P)'),
            trailing: Text(
              'x $quantity',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
