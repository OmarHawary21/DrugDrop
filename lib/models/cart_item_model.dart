class CartItemModel {
  final int productId;
  final String title;
  int quantity;
  final int price;
  final String imgUrl;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imgUrl,
  });
}
