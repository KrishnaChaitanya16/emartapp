class CartItem {
  final String productName;
  final String imageUrl;
  final String productPrice;
  int quantity;

  CartItem({
    required this.productName,
    required this.imageUrl,
    required this.productPrice,
    this.quantity = 1,
  });
}
