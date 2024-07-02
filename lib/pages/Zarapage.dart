import 'package:flutter/material.dart';
import 'package:emartapp/CustomScaffold.dart';

class Zarapage extends StatelessWidget {
  const Zarapage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: 'Zara Products',
      collectionName: 'zara', // Firestore collection name
    );
  }
}
