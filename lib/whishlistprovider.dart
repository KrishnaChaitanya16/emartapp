import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Product {
  final String name;
  final String image;
  final String price;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

class WishlistProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, Map<String, dynamic>> _wishlistItems = {};

  WishlistProvider() {
    _initializeWishlist();
  }

  // Initialize the wishlist for the user
  void _initializeWishlist() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String email = user.email!;
      CollectionReference wishlistRef = _firestore.collection('wishlists').doc(email).collection('items');

      // Check if the wishlist collection exists
      DocumentSnapshot docSnapshot = await _firestore.collection('wishlists').doc(email).get();
      if (!docSnapshot.exists) {
        // If the wishlist collection does not exist, create it
        await _firestore.collection('wishlists').doc(email).set({});
      }

      // Fetch the existing wishlist items
      QuerySnapshot snapshot = await wishlistRef.get();
      for (var doc in snapshot.docs) {
        _wishlistItems[doc.id] = {
          'image': doc['image'],
          'price': doc['price'],
          'description': doc['description'],
        };
      }
      notifyListeners();
    }
  }

  bool isInWishlist(String name) {
    return _wishlistItems.containsKey(name);
  }

  // Add or remove wishlist item
  void toggleWishlist(String name, String image, String price, String description) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String email = user.email!;
      DocumentReference docRef = _firestore.collection('wishlists').doc(email).collection('items').doc(name);

      if (isInWishlist(name)) {
        await docRef.delete();
        _wishlistItems.remove(name);
      } else {
        await docRef.set({
          'image': image,
          'price': price,
          'description': description,
        });
        _wishlistItems[name] = {
          'image': image,
          'price': price,
          'description': description,
        };
      }
      notifyListeners();
    }
  }

  Map<String, Map<String, dynamic>> get wishlistItems => _wishlistItems;
}
