import 'package:emartapp/pages/Appbarwidget.dart';
import 'package:emartapp/pages/Drawer%20widget.dart';
import 'package:emartapp/pages/GridViewwidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<String> ProductImages = [
      'assets/book1.jpg',
      'assets/habit.jpg',
      'assets/money.jpeg',
      'assets/power.jpeg',
      'assets/ikigai.jpg',
      'assets/db.jpg',
      'assets/oa.jpeg',
      'assets/rd.jpg',
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
                'Books',
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