import 'package:emartapp/pages/Appbarwidget.dart';
import 'package:emartapp/pages/Drawer%20widget.dart';
import 'package:emartapp/pages/GridViewwidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeautyPage extends StatelessWidget {
  const BeautyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<String> ProductImages = [
      'assets/bl2.jpeg',
      'assets/el1.jpeg',
      'assets/fp1.jpg',
      'assets/mc1.jpg',
      'assets/np1.jpg',
      'assets/sun1.jpeg',
      'assets/deal3.jpeg',
      'assets/sham1.jpeg',
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
                'Beauty Products',
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
