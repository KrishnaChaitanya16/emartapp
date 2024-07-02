import 'package:flutter/material.dart';
import 'dart:core';
import 'package:emartapp/CustomScaffold.dart'; // Adjust the import path as per your project structure

class Applepage extends StatelessWidget {
  const Applepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return CustomScaffold(
      pageTitle: 'Apple Products',

      collectionName: 'apple'
    );
  }
}
