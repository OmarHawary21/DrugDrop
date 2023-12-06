import 'cart_item_model.dart';

class OrderItemModel{
  final String id;
  final double total;
  final List<CartItemModel> products;
  final DateTime dateTime;

  OrderItemModel({
    required this.id,
    required this.total,
    required this.products,
    required this.dateTime,
});
}