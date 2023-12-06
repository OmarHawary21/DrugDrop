import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import '../providers/orders_provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() => _isLoading = true);
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<OrdersProvider>(context, listen: false).fetchOrders();
      setState(() => _isLoading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context);
    return orderProvider.orders.isEmpty
        ? const Center(
            child: Text('You have no orders'),
          )
        : ListView.builder(
            itemBuilder: (ctx, i) => OrderItem(orderProvider.orders[i]),
            itemCount: orderProvider.orders.length,
          );
  }
}
