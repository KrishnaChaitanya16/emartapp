import 'package:emartapp/cartmodel.dart';
import 'package:emartapp/cartprovider.dart';
import 'package:emartapp/whishlistprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: PriceGridView(
        screenWidth: MediaQuery.of(context).size.width,
        screenHeight: MediaQuery.of(context).size.height,
        products: wishlistProvider.wishlistItems.entries.map((entry) {
          final name = entry.key;
          final item = entry.value;
          return Product(
            name: name,
            image: item['image'] ?? '',
            price: item['price'] ?? '',
            description: item['description'] ?? '',
          );
        }).toList(),
      ),
    );
  }
}

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

        // Check if price contains '₹'
        final displayPrice = product.price.contains('₹') ? product.price : '₹${product.price}';

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
                SizedBox(height: 20),
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
                      displayPrice,
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          imagePath,
                          height: 400,
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
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  name,
                                  style: GoogleFonts.nunito(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Consumer<WishlistProvider>(
                                  builder: (context, wishlistProvider, child) {
                                    final isInWishlist = wishlistProvider.isInWishlist(name);
                                    return IconButton(
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
                                    );
                                  },
                                ),
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
                          SizedBox(height: 16),
                          Text(
                            price.contains('₹') ? price : '₹$price',
                            style: GoogleFonts.nunito(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final cartItem = CartItem(
                            imagePath: imagePath,
                            name: name,
                            price: double.parse(price.replaceAll('₹', '').replaceAll(',', '')),
                          );
                          cartProvider.addToCart(cartItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to Cart'),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
