import 'package:emartapp/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 // Assuming you have a ProductDetailsPage in a separate file

class ClothingPage extends StatelessWidget {
  const ClothingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menProducts = [
      {
        'name': 'Men\'s Shirt',
        'image': 'assets/shirt.jpeg',
        'description': 'Comfortable and stylish shirt for men.',
        'offerPrice': '\$99.99',
      },
      {
        'name': 'Men\'s T-shirt',
        'image': 'assets/tshirt.jpeg',
        'description': 'Casual t-shirt suitable for daily wear.',
        'offerPrice': '\$49.99',
      },
      {
        'name': 'Men\'s Pant',
        'image': 'assets/pant.jpeg',
        'description': 'Classic pant with a modern twist.',
        'offerPrice': '\$129.99',
      },
      {
        'name': 'Men\'s Cargos',
        'image': 'assets/cargos.jpeg',
        'description': 'Durable and comfortable cargo pants.',
        'offerPrice': '\$79.99',
      },
    ];

    final List<Map<String, dynamic>> womenProducts = [
      {
        'name': 'Women\'s Dress 1',
        'image': 'assets/fd1.jpg',
        'description': 'Elegant and stylish dress for women.',
        'offerPrice': '\$149.99',
      },
      {
        'name': 'Women\'s Dress 2',
        'image': 'assets/fd2.jpeg',
        'description': 'Beautiful dress perfect for special occasions.',
        'offerPrice': '\$199.99',
      },
      {
        'name': 'Women\'s Dress 3',
        'image': 'assets/fd3.jpeg',
        'description': 'Comfortable and trendy dress for everyday wear.',
        'offerPrice': '\$79.99',
      },
      {
        'name': 'Women\'s Dress 4',
        'image': 'assets/fd4.jpeg',
        'description': 'Chic and fashionable dress for modern women.',
        'offerPrice': '\$129.99',
      },
    ];

    Widget buildGridView(List<Map<String, dynamic>> products) {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailsPage(deal: products[index]),
              ));
            },
            child: Container(
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
                      products[index]['image'],
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    products[index]['name'],
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    products[index]['offerPrice'],
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Clothing',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Men\'s Clothing',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildGridView(menProducts),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Women\'s Clothing',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildGridView(womenProducts),
            ),
          ],
        ),
      ),
    );
  }
}
