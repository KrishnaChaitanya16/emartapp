import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:emartapp/cartprovider.dart';
import 'package:emartapp/whishlistprovider.dart';

class ClothingPage extends StatelessWidget {
  const ClothingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('mens clothing').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No products found.'));
                }
                final menProducts = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                return buildGridView(menProducts, context);
              },
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('womens clothing').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No products found.'));
                }
                final womenProducts = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                return buildGridView(womenProducts, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(List<Map<String, dynamic>> products, BuildContext context) {
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
                price: products[index]['offerprice'],
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
                          products[index]['offerprice'],
                          products[index]['description'],
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '₹${products[index]['offerprice']}',
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
}

class ProductDetailsPage extends StatefulWidget {
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
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String selectedSize = '';
  String selectedColor = '';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: true);

    final isInWishlist = wishlistProvider.isInWishlist(widget.name);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: GoogleFonts.nunito()),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        widget.imagePath,
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
                              widget.name,
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
                                  widget.name,
                                  widget.imagePath,
                                  widget.price,
                                  widget.description,
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.description,
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02), // Adjust spacing dynamically
                        Text(
                          '₹${widget.price}', // Ensure price string does not contain '$'
                          style: GoogleFonts.nunito(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Available Colors',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        buildColorOptions(), // Color options builder
                        SizedBox(height: 16),
                        Text(
                          'Available Sizes',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        buildSizeOptions(), // Size options builder
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedSize.isNotEmpty && selectedColor.isNotEmpty) {
                  // Add product to cart
                  final cartItem = CartItem(
                    imagePath: widget.imagePath,
                    name: widget.name,
                    price: double.parse(widget.price.replaceAll('₹', '').replaceAll(',', '')),
                  );
                  cartProvider.addToCart(cartItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select size and color'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
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
    );
  }

  Widget buildColorOptions() {
    List<String> colors = ['Red', 'Blue', 'Green', 'Orange']; // Replace with actual colors
    return Row(
      children: colors.map((color) {
        bool isSelected = selectedColor == color;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = color; // Update selected color
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isSelected ? Colors.grey : Colors.transparent,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: getColorFromString(color), // Get color from string method
                  ),
                ),
                if (isSelected)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.transparent, // Transparent background
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white, // White color for the tick
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color getColorFromString(String colorString) {
    // Logic to convert color string to Color object
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.deepOrangeAccent;
      default:
        return Colors.transparent;
    }
  }

  Widget buildSizeOptions() {
    List<String> sizes = ['S', 'M', 'L', 'XL']; // Replace with actual sizes
    return Row(
      children: sizes.map((size) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedSize = size; // Update selected size
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: selectedSize == size ? Colors.black : Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: selectedSize == size ? Colors.black : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: selectedSize == size ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}