import 'package:emartapp/cartmodel.dart';
import 'package:flutter/material.dart';
 // Ensure the path is correct

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(String name, String price, String image) {
    final existingIndex = _cartItems.indexWhere((item) => item.productName == name);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += 1;
    } else {
      _cartItems.add(CartItem(
        productName: name,
        imageUrl: image,
        productPrice: price,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(String name) {
    final existingIndex = _cartItems.indexWhere((item) => item.productName == name);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity -= 1;
      if (_cartItems[existingIndex].quantity <= 0) {
        _cartItems.removeAt(existingIndex);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
