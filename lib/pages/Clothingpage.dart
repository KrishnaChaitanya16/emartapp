import 'package:emartapp/cartmodel.dart';
import 'package:emartapp/cartprovider.dart';
import 'package:emartapp/pages/Homepage.dart';
import 'package:emartapp/whishlistprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
        'offerPrice': '99.99',
      },
      {
        'name': 'Men\'s T-shirt',
        'image': 'assets/tshirt.jpeg',
        'description': 'Casual t-shirt suitable for daily wear.',
        'offerPrice': '49.99',
      },
      {
        'name': 'Men\'s Pant',
        'image': 'assets/pant.jpeg',
        'description': 'Classic pant with a modern twist.',
        'offerPrice': '129.99',
      },
      {
        'name': 'Men\'s Cargos',
        'image': 'assets/cargos.jpeg',
        'description': 'Durable and comfortable cargo pants.',
        'offerPrice': '79.99',
      },
    ];

    final List<Map<String, dynamic>> womenProducts = [
      {
        'name': 'Women\'s Dress 1',
        'image': 'assets/fd1.jpg',
        'description': 'Elegant and stylish dress for women.',
        'offerPrice': '149.99',
      },
      {
        'name': 'Women\'s Dress 2',
        'image': 'assets/fd2.jpeg',
        'description': 'Beautiful dress perfect for special occasions.',
        'offerPrice': '199.99',
      },
      {
        'name': 'Women\'s Dress 3',
        'image': 'assets/fd3.jpeg',
        'description': 'Comfortable and trendy dress for everyday wear.',
        'offerPrice': '79.99',
      },
      {
        'name': 'Women\'s Dress 4',
        'image': 'assets/fd4.jpeg',
        'description': 'Chic and fashionable dress for modern women.',
        'offerPrice': '129.99',
      },
    ];

    Widget buildGridView(List<Map<String, dynamic>> products) {
      final wishlistProvider = Provider.of<WishlistProvider>(context, listen: true);

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
          final isInWishlist = wishlistProvider.isInWishlist(products[index]['name']);

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  imagePath: products[index]['image'],
                  name: products[index]['name'],
                  price: products[index]['offerPrice'],
                  description: products[index]['description'],
                ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          products[index]['name'],
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: isInWishlist ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          wishlistProvider.toggleWishlist(
                            products[index]['name'],
                            products[index]['image'],
                            products[index]['offerPrice'],
                            products[index]['description'],
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${products[index]['offerPrice']}',
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
class ProductDetailsPage extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final String description;

  const ProductDetailsPage({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: true);

    final isInWishlist = wishlistProvider.isInWishlist(name);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: GoogleFonts.nunito()),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imagePath,
                  height: screenHeight * 0.4, // Adjust image height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: isInWishlist ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          wishlistProvider.toggleWishlist(
                            name,
                            imagePath,
                            price,
                            description,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Adjust spacing dynamically
                  Text(
                    '₹$price', // Ensure price string does not contain '$'
                    style: GoogleFonts.nunito(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.28), // Adjust spacing dynamically
                  ElevatedButton(
                    onPressed: () {
                      // Add product to cart
                      final cartItem = CartItem(
                        imagePath: imagePath,
                        name: name,
                        price: double.parse(price.replaceAll('₹', '').replaceAll(',', '')),
                      );
                      cartProvider.addToCart(cartItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to cart'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.black,
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Add to Cart',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}