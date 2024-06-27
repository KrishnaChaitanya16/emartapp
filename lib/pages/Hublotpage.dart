import 'package:flutter/material.dart';
import 'dart:core';
import 'package:emartapp/CustomScaffold.dart'; // Adjust the import path as per your project structure

class Hublotpage extends StatelessWidget {
  const Hublotpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> HublotProducts = [
      {
        'imagePath': 'assets/hublot1.jpeg',
        'name': 'Hublot  Fusion',
        'details':"The Hublot Classic Fusion combines timeless elegance with modern sophistication. Featuring a sleek and minimalist design, this watch boasts a polished stainless steel case and a black sunray dial. With its understated luxury and Swiss craftsmanship, it is a versatile accessory for any occasion.",
        'price': '29.99'
      },
      {
        'imagePath': 'assets/hublot2.jpeg',
        'name': ' Hublot Big Bang',
        'details':"Embrace boldness with the Hublot Big Bang Chronograph. This iconic timepiece features a 44mm ceramic case with a satin-finished bezel and a black carbon fiber dial. Powered by an automatic movement, it offers precision timekeeping and a sporty aesthetic, ideal for active lifestyles.",
        'price': '49.99'
      },
      {
        'imagePath' : 'assets/hublot3.jpeg',
        'name' : 'Spirit Of Big Bang',
        'details':"The Hublot Spirit of Big Bang showcases a distinctive tonneau-shaped case crafted from titanium. Its skeletonized dial reveals the intricate mechanics of the in-house movement, while the black rubber strap ensures comfort and durability. With its avant-garde design, it captures the essence of innovation and luxury.",
        'price': '39.99'
      },
      {
        'imagePath' : 'assets/hublot4.jpeg',
        'name' : 'Hublot King Gold',
        'details': "Make a statement with the Hublot Classic Fusion Blue King Gold. This luxurious timepiece features a polished 18K King Gold case with a satin-finished blue sunray dial. Enhanced with a blue rubber strap, it offers a harmonious blend of elegance and contemporary style, perfect for the modern gentleman.",
        'price': '89.99'
      },
      {
        'imagePath' :'assets/hublot5.jpeg',
        'name' :'Hublot Unico',
        'details':"Experience precision engineering with the Hublot Big Bang Unico. Crafted from stainless steel, this watch features a 45mm case with a skeletonized dial showcasing the intricate UNICO movement. With its chronograph function and black rubber strap, it embodies performance and sophistication.",
        'price':'99.99'
      },
      {
        'imagePath': 'assets/hublot6.png',
        'name' : 'Hublot King Power',
        'details':"The Hublot King Power exudes masculine strength with its robust design and innovative features. Featuring a 48mm ceramic case and a black carbon fiber dial, this watch is powered by a self-winding movement and equipped with a chronograph complication. With its sporty appeal and durable construction, it is built for adventure and style.",
        'price' : '77.99'
      }
    ];


    return CustomScaffold(
      pageTitle: 'Hublot Products',
      productList: HublotProducts,
    );
  }
}
