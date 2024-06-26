import 'package:emartapp/cartmodel.dart';
import 'package:flutter/material.dart';
 // Import your CartItem model

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Add to cart method
  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  // Remove from cart method (if needed)
  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  // Increment item quantity in cart
  void incrementItem(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  // Decrement item quantity in cart, and remove if quantity becomes zero
  void decrementItem(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cartItems.remove(item);
    }
    notifyListeners();
  }

  // Calculate total price of items in cart
  double getTotalPrice() {
    double total = 0.0;
    _cartItems.forEach((item) {
      total += (item.price * item.quantity) as double;
    });
    return total;
  }
}