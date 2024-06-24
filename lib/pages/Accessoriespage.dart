import 'package:emartapp/pages/Appbarwidget.dart';
import 'package:emartapp/pages/Drawer%20widget.dart';
import 'package:emartapp/pages/GridViewwidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessoriesPage extends StatelessWidget {
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<String> ProductImages = [
      'assets/handbag1.png',
      'assets/sunglasses1.jpg',
      'assets/watch.png',
      'assets/sunglasses2.jpeg',
      'assets/handbag2.jpeg',
      'assets/earrings.jpg',
      'assets/braclet.jpg',
      'assets/ring1.jpeg',
      // Add more image paths as needed
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        showLeading: true,
      ),
      drawer: CustomDrawer(screenWidth: screenWidth),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Electronics',
                style: GoogleFonts.nunito(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            PriceGridView(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              productImages: ProductImages,
            ),
          ],
        ),
      ),
    );
  }
}