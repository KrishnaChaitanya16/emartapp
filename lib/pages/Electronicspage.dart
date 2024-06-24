import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emartapp/pages/Appbarwidget.dart';
import 'package:emartapp/pages/Drawer widget.dart';
import 'package:emartapp/pages/GridViewwidget.dart'; // Assuming PriceGridView is implemented here

class ElectronicsPage extends StatelessWidget {
  const ElectronicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<String> productImages = [
      'assets/deal1.jpeg',
      'assets/fridge1.png',
      'assets/fridge2.png',
      'assets/headphones2.png',
      'assets/lgtv.jpeg',
      'assets/samsungphone.jpg',
      'assets/oneplustv.jpeg',
      'assets/sonyheadphones.jpg',
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
              productImages: productImages,
            ),
          ],
        ),
      ),
    );
  }
}
