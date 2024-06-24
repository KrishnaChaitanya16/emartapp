import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceGridView extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final List<String> productImages; // List of image paths for each product

  PriceGridView({
    required this.screenWidth,
    required this.screenHeight,
    required this.productImages, // Pass the list of image paths
  });

  @override
  Widget build(BuildContext context) {
    // Ensure that the productImages list has exactly 8 items
    List<String> limitedImages = productImages.take(8).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: limitedImages.length, // Always 8 items
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          limitedImages[index], // Use the image path for this product
                          height: screenHeight * 0.15,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Product Name',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$99.99',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
