import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/order_item_model.dart';
import '../models/cart_item_model.dart';

class OrdersProvider extends ChangeNotifier {
  List<OrderItemModel> _orders = [
    OrderItemModel(
      id: '0',
      total: 113.83,
      products: [
        CartItemModel(
          id: '0',
          title: 'test',
          quantity: 2,
          price: 15.22,
        ),
        CartItemModel(
          id: '1',
          title: 'test1',
          quantity: 5,
          price: 6.48,
        ),
        CartItemModel(
          id: '2',
          title: 'test2',
          quantity: 1,
          price: 50.99,
        ),
        CartItemModel(
          id: '2',
          title: 'test2',
          quantity: 1,
          price: 50.99,
        ),
        CartItemModel(
          id: '2',
          title: 'test2',
          quantity: 1,
          price: 50.99,
        ),
        CartItemModel(
          id: '2',
          title: 'test2',
          quantity: 1,
          price: 50.99,
        ),
        CartItemModel(
          id: '2',
          title: 'test2',
          quantity: 1,
          price: 50.99,
        ),
      ],
      dateTime: DateTime.now(),
    ),
    OrderItemModel(
      id: '1',
      total: 113.83,
      products: [
        CartItemModel(
          id: '0',
          title: 'test',
          quantity: 2,
          price: 15.22,
        ),
        CartItemModel(
          id: '1',
          title: 'test1',
          quantity: 5,
          price: 6.48,
        ),
        CartItemModel(
          id: '2',
          title: 'test2',
          quantity: 1,
          price: 50.99,
        ),
      ],
      dateTime: DateTime.now(),
    ),
    OrderItemModel(
      id: '2',
      total: 113.83,
      products: [
        CartItemModel(
          id: '0',
          title: 'test',
          quantity: 2,
          price: 15.22,
        ),
        CartItemModel(
          id: '1',
          title: 'test1',
          quantity: 5,
          price: 6.48,
        ),
        CartItemModel(
          id: '2',
          title: 'test2',
          quantity: 1,
          price: 50.99,
        ),
      ],
      dateTime: DateTime.now(),
    ),
  ];

  // final String token;
  // final String userId;
  //
  // OrdersProvider(this.token, this.userId, this._orders);

  List<OrderItemModel> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    // final url = Uri.parse(
    //     'https://shop-app-8cd8f-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final url = Uri.parse(
        'https://shop-app-8cd8f-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    final List<OrderItemModel> loadedOrders = [];
    final fetchedOrders = json.decode(response.body) == null
        ? null
        : json.decode(response.body) as Map<String, dynamic>;
    if (fetchedOrders == null) {
      return;
    }
    fetchedOrders.forEach((orderId, orderData) {
      loadedOrders.add(OrderItemModel(
        id: orderId,
        total: orderData['total'],
        products: (orderData['products'] as List<dynamic>)
            .map((product) => CartItemModel(
                  id: product['id'],
                  title: product['title'],
                  quantity: product['quantity'],
                  price: product['price'],
                ))
            .toList(),
        dateTime: DateTime.parse(orderData['time']),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> placeOrder(
      List<CartItemModel> cartProducts, double total) async {
    // final url = Uri.parse(
    //     'https://shop-app-8cd8f-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final url = Uri.parse(
        'https://shop-app-8cd8f-default-rtdb.firebaseio.com/orders.json');
    final time = DateTime.now();
    if (cartProducts.isNotEmpty) {
      final response = await http.post(
        url,
        body: json.encode({
          'total': total,
          'time': time.toIso8601String(),
          'products': cartProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'title': cartProduct.title,
                    'quantity': cartProduct.quantity,
                    'price': cartProduct.price,
                  })
              .toList(),
        }),
      );
      _orders.insert(
        0,
        OrderItemModel(
          id: json.decode(response.body)['name'],
          total: total,
          products: cartProducts,
          dateTime: time,
        ),
      );
      notifyListeners();
    }
  }
}
