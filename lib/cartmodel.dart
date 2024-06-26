class CartItem {
  final String imagePath;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.imagePath,
    required this.name,
    required this.price,
    this.quantity = 1, // Default quantity is 1
  });
}