import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../cartmodel.dart';
import '../cartprovider.dart';
import '../whishlistprovider.dart';

class Product {
  final String name;
  final String image;
  final String price;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

class GroceriesPage extends StatelessWidget {
  const GroceriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final List<Product> products = [
      Product(
        name: 'Mango',
        image: 'assets/mango.jpg',
        price: '9.99',
        description: 'Fresh and juicy mangoes.',
      ),
      Product(
        name: 'Butter',
        image: 'assets/butter.jpg',
        price: '19.99',
        description: 'Premium quality butter.',
      ),
      Product(
        name: 'Bread',
        image: 'assets/bread.png',
        price: '14.99',
        description: 'Whole grain bread.',
      ),
      Product(
        name: 'Dairy Milk',
        image: 'assets/dairymilk.png',
        price: '29.99',
        description: 'Creamy dairy milk chocolate.',
      ),
      Product(
        name: 'Biscuit',
        image: 'assets/biscuit.jpg',
        price: '24.99',
        description: 'Crunchy biscuits.',
      ),
      Product(
        name: 'Lays',
        image: 'assets/lays.png',
        price: '39.99',
        description: 'Potato chips.',
      ),
      Product(
        name: 'Veggies',
        image: 'assets/veggies.jpg',
        price: '49.99',
        description: 'Fresh vegetables.',
      ),
      Product(
        name: 'Milk',
        image: 'assets/milk.png',
        price: '54.99',
        description: 'Fresh milk.',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Groceries',
          style: GoogleFonts.nunito(
            fontSize: 25,
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
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ProductGridView(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                products: products,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGridView extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final List<Product> products;

  const ProductGridView({
    required this.screenWidth,
    required this.screenHeight,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
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
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  imagePath: product.image,
                  name: product.name,
                  price: product.price,
                  description: product.description,
                ),
              ),
            );
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
                    product.image,
                    height: screenHeight * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  product.name,
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${product.price}',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      color: Colors.grey,
                      onPressed: () {
                        // Implement wishlist addition logic here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
