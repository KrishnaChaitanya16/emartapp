import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cartmodel.dart'; // Import your CartItem model

class CartProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Add to cart method
  Future<void> addToCart(CartItem item) async {
    String userEmail = _auth.currentUser!.email!;

    try {
      // Check if the document exists
      DocumentSnapshot userCartSnapshot = await _firestore.collection('carts').doc(userEmail).get();

      if (userCartSnapshot.exists) {
        // Document exists, update the cartItems array
        await _firestore.collection('carts').doc(userEmail).update({
          'cartItems': FieldValue.arrayUnion([item.toMap()]),
        });
      } else {
        // Document does not exist, create a new document
        await _firestore.collection('carts').doc(userEmail).set({
          'cartItems': [item.toMap()],
        });
      }

      _cartItems.add(item);
      notifyListeners();
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  // Fetch user cart
  Future<void> fetchUserCart() async {
    String userEmail = _auth.currentUser!.email!;

    try {
      DocumentSnapshot userCartSnapshot = await _firestore.collection('carts').doc(userEmail).get();

      if (userCartSnapshot.exists) {
        List<dynamic> cartItemsData = userCartSnapshot.get('cartItems');
        _cartItems = cartItemsData.map((item) => CartItem.fromMap(item)).toList();
        notifyListeners();
      } else {
        // If document does not exist, create it
        await _firestore.collection('carts').doc(userEmail).set({
          'cartItems': [],
        });
      }
    } catch (e) {
      print('Error fetching user cart: $e');
    }
  }

  // Remove from cart method
  Future<void> removeFromCart(CartItem item) async {
    String userEmail = _auth.currentUser!.email!;

    try {
      await _firestore.collection('carts').doc(userEmail).update({
        'cartItems': FieldValue.arrayRemove([item.toMap()]),
      });

      _cartItems.remove(item);
      notifyListeners();
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  // Increment item quantity in cart
  Future<void> incrementItem(CartItem item) async {
    String userEmail = _auth.currentUser!.email!;

    item.quantity++;
    try {
      await _firestore.collection('carts').doc(userEmail).update({
        'cartItems': _cartItems.map((item) => item.toMap()).toList(),
      });
      notifyListeners();
    } catch (e) {
      print('Error incrementing item: $e');
    }
  }

  // Decrement item quantity in cart, and remove if quantity becomes zero
  Future<void> decrementItem(CartItem item) async {
    String userEmail = _auth.currentUser!.email!;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cartItems.remove(item);
    }
    try {
      await _firestore.collection('carts').doc(userEmail).update({
        'cartItems': _cartItems.map((item) => item.toMap()).toList(),
      });
      notifyListeners();
    } catch (e) {
      print('Error decrementing item: $e');
    }
  }

  // Calculate total price of items in cart
  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
