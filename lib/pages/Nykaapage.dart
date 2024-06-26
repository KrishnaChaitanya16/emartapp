import 'package:emartapp/pages/Nikepage.dart';
import 'package:flutter/material.dart';
import 'package:emartapp/CustomScaffold.dart';
import 'dart:core';// Adjust the import path as per your project structure

class Nykaapage extends StatelessWidget {
  const Nykaapage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> nykaaProducts = [
      {
        'imagePath': 'assets/nykaa1.jpeg',
        'name': 'Product 1',
        'details': "Achieve flawless skin with Nykaa's Foundation, designed to provide seamless coverage and a natural finish. Enriched with skin-loving ingredients like SPF and antioxidants, it not only conceals imperfections but also protects and hydrates your skin throughout the day. Available in a variety of shades to match every skin tone, Nykaa's Foundation ensures a radiant complexion with a lightweight feel, perfect for all-day wear."





      ,
        'price': '29.99'
      },
      {
        'imagePath': 'assets/nykaa2.jpeg',
        'name': 'Product 2',
        'details': "Nykaa's Serums deliver targeted skincare benefits with potent ingredients like vitamin C and hyaluronic acid. From brightening to anti-aging, each serum revitalizes and nourishes your skin for a radiant, youthful glow.",
        'price': '49.99'
      },
      {
        'imagePath' : 'assets/nykaa3.jpeg',
        'name' : 'Product3',
        'details': "Discover Nykaa's Liquid Foundation, your secret to a flawless complexion. Formulated with lightweight yet buildable coverage, this foundation effortlessly blends into the skin for a natural finish. Enriched with hydrating ingredients and available in a spectrum of shades, it provides lasting comfort and a radiant glow. Whether you prefer a dewy or matte look, Nykaa's Liquid Foundation caters to all skin types, ensuring a seamless and luminous complexion with every application.",
        'price': '39.99'
      },
      {
        'imagePath' : 'assets/nykaa4.jpeg',
        'name' : 'Product4',
        'details':"Indulge in Nykaa's Maroon Lipstick, a bold and sophisticated shade that makes a statement. With its rich pigment and creamy texture, this lipstick glides on smoothly, delivering intense color and long-lasting wear. Perfect for adding a touch of glamour to any look, Nykaa's Maroon Lipstick promises a luxurious finish that enhances your natural beauty with every application.",
        'price': '89.99'
      },
      {
        'imagePath' :'assets/nykaa5.jpeg',
        'name' :'Product5',
        'details': "Nykaa's Serums deliver targeted skincare benefits with potent ingredients like vitamin C and hyaluronic acid. From brightening to anti-aging, each serum revitalizes and nourishes your skin for a radiant, youthful glow."

      ,
        'price':'99.99'
      },
      {
        'imagePath': 'assets/nykaa6.jpeg',
        'name' : 'Product6',
        'details': "Indulge in Nykaa's Body Lotions, enriched with nourishing oils and vitamins. These luxurious formulations deeply hydrate and soften your skin, leaving it velvety smooth with a delightful fragrance."

      ,
        'price' : '77.99'
      }
    ];


    return CustomScaffold(
      pageTitle: 'Nykaa Products',
      productList: nykaaProducts,
    );
  }
}
