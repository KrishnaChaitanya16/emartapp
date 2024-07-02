class CartItem {
  final String imagePath;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.imagePath,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      imagePath: map['imagePath'],
      name: map['name'],
      price: double.tryParse(map['price'].toString().replaceAll('₹', '').replaceAll(',', '')) ?? 0.0,
      quantity: map['quantity'] ?? 1,
    );
  }
}
