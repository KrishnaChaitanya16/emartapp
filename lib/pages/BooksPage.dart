import 'package:emartapp/cartmodel.dart';
import 'package:emartapp/cartprovider.dart';
import 'package:emartapp/whishlistprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Define the product model
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

// BooksPage class
class BooksPage extends StatelessWidget {
  const BooksPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<Product> products = [
      Product(
        name: 'You Can',
        image: 'assets/book1.jpg',
        price: '129.00',
        description: "Empower yourself. \"You Can\" provides motivational insights and practical advice to help you realize your potential, overcome obstacles, and achieve personal and professional success."


      ),
      Product(
        name: 'Atomic Habits',
        image: 'assets/habit.jpg',
        price: '449.00',
        description: 'Transform your life with small changes. "Atomic Habits" offers practical strategies to build good habits, break bad ones, and master the tiny behaviors that lead to remarkable results.',
      ),
      Product(
        name: 'Pyschology of Money',
        image: 'assets/money.jpeg',
        price: '269.00',
        description: 'Explore the human side of finance. "The Psychology of Money" delves into the behaviors and attitudes that shape our financial decisions, offering timeless lessons on wealth, greed, and happiness.',
      ),
      Product(
        name: 'The Power of Subconcious Mind',
        image: 'assets/power.jpeg',
        price: '149.00',
        description: "Unlock your mind's potential. This classic book teaches how to harness the power of your subconscious mind to achieve your goals, improve your health, and create the life you desire.",
      ),
      Product(
        name: 'Ikigai',
        image: 'assets/ikigai.jpg',
        price: '249.00',
        description: 'Discover your purpose. "Ikigai" explores the Japanese concept of finding joy through purpose, offering insights into living a longer, more fulfilling life by doing what you love.',


      ),
      Product(
        name: "Don't belive everyhting you Think",
        image: 'assets/db.jpg',
        price: '169.00',
        description: 'Challenge your thoughts. This book provides tools to understand and reframe negative thinking, helping you to cultivate a positive mindset and improve your overall well-being.',


      ),
      Product(
        name: 'One Arranged Murder',
        image: 'assets/oa.jpeg',
        price: '172.00',
        description: 'A thrilling mystery. "One Arranged Murder" blends romance and suspense in a gripping tale of love, betrayal, and a murder investigation that keeps you guessing until the end.',


      ),
      Product(
        name: 'Rich Dad Poor Dad',
        image: 'assets/rd.jpg',
        price: '322.00',
        description: "Financial wisdom simplified. \"Rich Dad Poor Dad \" shares lessons on money management and investing, contrasting the financial philosophies of the author's two \" dads \" to offer valuable insights into wealth-building.",
      ),
      // Add more products as needed
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Books',
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
              child: PriceGridView(
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

// PriceGridView class
class PriceGridView extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final List<Product> products;

  const PriceGridView({
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
        final displayName = product.name.length > 18
            ? '${product.name.substring(0, 16)}...' // Truncate to 16 characters and add ...
            : product.name;

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
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  displayName,
                  maxLines: 2, // Limiting to 2 lines
                  overflow: TextOverflow.ellipsis, // Show dots for overflow
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
                    Consumer<WishlistProvider>(
                      builder: (context, wishlistProvider, child) {
                        final isInWishlist = wishlistProvider.isInWishlist(product.name);
                        return IconButton(
                          icon: Icon(
                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                            color: isInWishlist ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            wishlistProvider.toggleWishlist(
                              product.name,
                              product.image,
                              product.price,
                              product.description,
                            );
                          },
                        );
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
// ProductDetailsPage class
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