import 'package:flutter/material.dart';
import 'dart:core';
import 'package:emartapp/CustomScaffold.dart'; // Adjust the import path as per your project structure

class Applepage extends StatelessWidget {
  const Applepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> appleProducts = [
      {
        'imagePath': 'assets/apple1.jpeg',
        'name': 'Product 1',
        'details': 'Experience the pinnacle of innovation with the iPhone 15 Pro Max. Featuring a stunning Super Retina XDR display, an advanced A-series chip for unparalleled performance, and a revolutionary camera system with enhanced low-light capabilities, it redefines what a smartphone can do',
        'price': '29.99'
      },
      {
        'imagePath': 'assets/apple2.jpeg',
        'name': 'Product 2',
        'details' : "The MacBook Pro sets the standard for performance and portability. Powered by the latest Intel or Apple Silicon chip, it delivers exceptional speed and efficiency. With a stunning Retina display, advanced graphics, and long battery life, it's the ultimate tool for creative professionals and power users."

      ,
        'price': '49.99'
      },
     {
       'imagePath' : 'assets/apple3.jpeg',
       'name' : 'Product3',
       'details':"Elevate your fitness and connectivity with the Apple Watch. Featuring a sleek design, advanced health tracking capabilities, and access to a wide range of apps and notifications, it keeps you connected and motivated throughout your day.",
       'price': '39.99'
     },
      {
        'imagePath' : 'assets/apple4.jpeg',
        'name' : 'Product4',
        'details':"The iPad combines power and versatility in a sleek, portable design. With its vibrant Retina display, powerful A-series chip, and support for the Apple Pencil and Smart Keyboard, it offers a seamless experience for work, creativity, and entertainment.",
        'price': '89.99'
      },
      {
        'imagePath' :'assets/apple5.jpeg',
        'name' :'Product5',
        'details':"Enjoy wireless freedom with AirPods. Offering seamless connectivity, crystal-clear sound, and intuitive controls, they deliver an immersive listening experience. With features like active noise cancellation and spatial audio, AirPods redefine how you experience music and calls.",
        'price':'99.99'
      },
      {
        'imagePath': 'assets/apple6.jpeg',
        'name' : 'Product6',
        'details':"Transform your home audio with the HomePod. Featuring immersive 360-degree sound, Siri integration for hands-free control, and smart home connectivity, it delivers rich, high-fidelity audio in a compact design. Perfect for enhancing your listening experience and managing your smart home devices effortlessly.",
        'price' : '77.99'
      }
    ];


    return CustomScaffold(
      pageTitle: 'Apple Products',
      productList: appleProducts,
    );
  }
}
