import 'package:flutter/material.dart';


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
  Map<String, Map<String, dynamic>> _wishlistItems = {};

  bool isInWishlist(String name) {
    return _wishlistItems.containsKey(name);
  }

  void toggleWishlist(String name, String image, String price, String description) {
    if (isInWishlist(name)) {
      _wishlistItems.remove(name);
    } else {
      _wishlistItems[name] = {
        'image': image,
        'price': price,
        'description': description,
      };
    }
    notifyListeners();
  }

  Map<String, Map<String, dynamic>> get wishlistItems {
    return _wishlistItems;
  }
}