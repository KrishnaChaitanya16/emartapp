import 'package:flutter/material.dart';
import 'package:emartapp/CustomScaffold.dart';
import 'dart:core';// Adjust the import path as per your project structure

class Nikepage extends StatelessWidget {
  const Nikepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> nikeProducts = [
      {
        'imagePath': 'assets/nikee2.jpeg',
        'name': 'Product 1',
        'details': "The Nike Air Max combines iconic style with visible Air cushioning. Featuring a lightweight mesh upper and a supportive midsole, this shoe delivers all-day comfort and cushioning. With its classic design and bold colorways, it's perfect for casual wear and athletic performance.",


        'price': '29.99'
      },
      {
        'imagePath': 'assets/nike2.jpeg',
        'name': 'Product 2',
        'details': "Embrace timeless style with the Nike Air Force 1. Known for its clean lines and premium leather upper, this shoe offers durability and a classic aesthetic. With a low-cut silhouette and Nike Air cushioning, it provides lightweight comfort and a sleek look for everyday wear."

      ,
        'price': '49.99'
      },
      {
        'imagePath' : 'assets/nike3.jpeg',
        'name' : 'Product3',
        'details': "Elevate your running experience with the Nike React Infinity Run. Designed for long-distance comfort and support, this shoe features a Flyknit upper for a snug fit and React foam cushioning for responsive energy return. With its stable platform and modern design, it's ideal for runners seeking a smooth and reliable ride."

      ,
        'price': '39.99'
      },
      {
        'imagePath' : 'assets/nike4.png',
        'name' : 'Product4',
        'details': "Experience versatility and performance with the Nike Zoom Pegasus. Built for speed and comfort, this running shoe features a responsive Zoom Air unit in the forefoot and midsole for cushioned support. With its breathable mesh upper and secure fit, it's suitable for daily training and racing.",
        'price': '89.99'
      },
      {
        'imagePath' :'assets/nike5.jpeg',
        'name' :'Product5',
        'details': "Celebrate basketball heritage with the Nike Air Jordan Retro. Inspired by classic Jordan designs, this shoe features premium leather construction and iconic Air Jordan branding. With its high-top silhouette and Air-Sole unit in the heel, it offers enhanced cushioning and support on and off the court.",
        'price':'99.99'
      },
      {
        'imagePath': 'assets/nike6.jpeg',
        'name' : 'Product6',
        'details': "Explore urban skate culture with the Nike SB Dunk Low. Designed for skateboarding performance, this shoe features a durable suede and leather upper for stability and a Zoom Air unit in the heel for responsive cushioning. With its low-profile design and grippy rubber outsole, it provides traction and boardfeel for optimal skate sessions.",
        'price' : '77.99'
      }
    ];


    return CustomScaffold(
      pageTitle: 'Nike Products',
      productList: nikeProducts,
    );
  }
}
