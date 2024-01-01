import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: SlideInUp(
        duration: const Duration(milliseconds: 800),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => CartItem(
                  cart.items[i].id,
                  cart.items[i].productId,
                  cart.items[i].title,
                  cart.items[i].price,
                  cart.items[i].quantity,
                ),
                itemCount: cart.items.length,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Total: ',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            Chip(
              label: Text(
                '1600 (S.P)',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              side: BorderSide.none,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            // OrderButton(cart),
          ],
        ),
      ),
      floatingActionButton: Container(
        transform: Matrix4.translationValues(0, -40, 0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.local_shipping,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final CartProvider cart;

  OrderButton(this.cart);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    bool _isDisabled = (widget.cart.items.length <= 0);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        foregroundColor:
            _isDisabled ? Colors.grey : Theme.of(context).colorScheme.primary,
        side: BorderSide(
          color:
              _isDisabled ? Colors.grey : Theme.of(context).colorScheme.primary,
        ),
      ),
      onPressed: () {},
      child: _isDisabled
          ? const Text(
              'Nothing to order',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            )
          : const Text(
              'Place Order',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
    );
  }
}
