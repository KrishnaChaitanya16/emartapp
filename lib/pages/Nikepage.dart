import 'package:flutter/material.dart';
import 'package:emartapp/CustomScaffold.dart';
import 'dart:core';// Adjust the import path as per your project structure

class Nikepage extends StatelessWidget {
  const Nikepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return CustomScaffold(
      pageTitle: 'Nike Products',

      collectionName:'nike'
    );
  }
}
