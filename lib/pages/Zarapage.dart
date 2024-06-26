import 'package:flutter/material.dart';
import 'package:emartapp/CustomScaffold.dart';
import 'dart:core';// Adjust the import path as per your project structure

class Zarapage extends StatelessWidget {
  const Zarapage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> zaraProducts = [
      {
        'imagePath': 'assets/zara1.jpeg',
        'name': 'Product 1',
        'details':'Discover timeless sophistication with the Black Zara Button-Up Shirt. Crafted from a premium cotton blend, it offers a sleek, minimalist design perfect for both casual and formal settings. Ideal for effortlessly elevating your everyday style.',







        'price': '29.99'
      },
      {
        'imagePath': 'assets/zara2.jpeg',
        'name': 'Product 2',
        'details': 'Create a chic statement with our White Layered Outfit, pairing a classic white shirt with a lightweight jacket for a sophisticated look. Crafted from premium materials, this ensemble ensures comfort and style, ideal for versatile day-to-night wear.',
        'price': '49.99'
      },
      {
        'imagePath' : 'assets/zara3.jpeg',
        'name' : 'Product3',
        'details':'Introducing our Full Sleeved Black and White Sweatshirt, a fusion of comfort and style. Crafted with soft, breathable fabric, this sweatshirt features a contemporary black and white design that effortlessly blends casual appeal with urban flair. Ideal for all-day comfort and modern streetwear versatility.',
        'price': '39.99'
      },
      {
        'imagePath' : 'assets/zara4.jpeg',
        'name' : 'Product4',
        'details':'Introducing our Red Full-Sleeve Shirt, a vibrant addition to your wardrobe. Made from premium cotton, it offers a comfortable fit and a bold statement with its rich red hue. Perfect for adding a pop of color to any ensemble, whether dressed up or down.',
        'price': '89.99'
      },
      {
        'imagePath' :'assets/zara5.jpeg',
        'name' :'Product5',
        'details':'Presenting our Green Suit, a symbol of refined elegance and contemporary style. Tailored from high-quality fabric, this suit exudes sophistication with its rich green hue, perfect for formal events or a stylish evening out. Embrace timeless class with every detail meticulously crafted for a distinguished appearance.',
        'price':'99.99'
      },
      {
        'imagePath': 'assets/zara7.jpeg',
        'name' : 'Product6',
        'details': 'Introducing the Zara Men Perfume, a signature scent that embodies sophistication and allure. With notes of citrus, spice, and woody undertones, this fragrance offers a modern yet timeless appeal. Perfect for the confident man who values refinement and individuality, making it an essential addition to any grooming routine.',
        'price' : '77.99'
      }
    ];


    return CustomScaffold(
      pageTitle: 'Zara Products',
      productList: zaraProducts,
    );
  }
}