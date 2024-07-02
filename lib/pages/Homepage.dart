import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/cartmodel.dart';
import 'package:emartapp/cartprovider.dart';
import 'package:emartapp/pages/Applepage.dart';
import 'package:emartapp/pages/Cartpage.dart';
import 'package:emartapp/pages/Hublotpage.dart';
import 'package:emartapp/pages/Nikepage.dart';
import 'package:emartapp/pages/Nykaapage.dart';

import 'package:emartapp/pages/Zarapage.dart';
import 'package:emartapp/pages/profilepage.dart';
import 'package:emartapp/pages/wishlistpage.dart';
import 'package:emartapp/whishlistprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import the respective category pages
import 'package:emartapp/pages/Accessoriespage.dart';
import 'package:emartapp/pages/Beautypage.dart';
import 'package:emartapp/pages/BooksPage.dart';
import 'package:emartapp/pages/Clothingpage.dart';
import 'package:emartapp/pages/Electronicspage.dart';
import 'package:emartapp/pages/Groceriespage.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, String>> categories = [
    {'name': 'Accessories', 'image': 'assets/acessories.jpeg'},
    {'name': 'Electronics', 'image': 'assets/electronics.png'},
    {'name': 'Clothing', 'image': 'assets/dress.jpeg'},
    {'name': 'Groceries', 'image': 'assets/grocery.jpeg'},
    {'name': 'Books', 'image': 'assets/books.jpeg'},
    {'name': 'Beauty', 'image': 'assets/bueaty.jpeg'}
  ];
  final List<Widget> Brands = [
   Zarapage(),
    Nykaapage(),
    Applepage(),
    Hublotpage(),
    Nikepage()
  ];
  int selectedIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  final List<String> featuredImages = [
    'assets/macbook deal.jpg',
    'assets/clothingdeals.jpg',
    'assets/cosmeticdeals.jpeg',
    'assets/groceries-offers.jpg',
  ];

  final List<String> popularBrands = [
    'assets/brand1.png',
    'assets/brand2.png',
    'assets/brand3.png',
    'assets/watchlogo.png',
    'assets/brand5.png',
  ];

  final List<Widget> detailPages = [
    ElectronicsPage(),
    ClothingPage(),
    BeautyPage(),
    GroceriesPage(),
  ];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.page == featuredImages.length - 1) {
        _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Filtered categories based on search query
    List<Map<String, String>> filteredCategories = categories.where((category) {
      return category['name']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.03),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Container(
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.02,
                  ),
                ),
                style: GoogleFonts.nunito(color: Colors.black),
              ),
            ),
            actions: [
              InkWell(
              onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartPage()), // Replace CartPage with your actual cart page widget
        );
        },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'lib/icons/bag.png',
                    width: 24,
                    height: 24,
                    color: Colors.black,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            iconTheme: IconThemeData(color: Colors.black),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset(
                    'lib/icons/menu.png',
                    width: 24,
                    height: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/icons/shopping-bag.png',
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      color: Colors.black,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Shopeez.',
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: SizedBox(child: Image.asset('lib/icons/home.png',fit: BoxFit.cover,),height: 20,width: 20,),
                      title: Text('Home', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 30,),
                    ListTile(
                      leading: SizedBox(child: Image.asset('lib/icons/user.png',fit: BoxFit.cover,),height: 20,width: 20,),
                      title: Text('Profile', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                        );
                      },
                    ),
                    SizedBox(height: 30,),
                    ListTile(
                      leading: SizedBox(child: Image.asset('lib/icons/shopping-bag.png',fit: BoxFit.cover,),height: 20,width: 20,),
                      title: Text('Cart', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));

                      },
                    ),
                    SizedBox(height: 30,),
                    ListTile(
                      leading: SizedBox(child: Image.asset('lib/icons/wishlist.png',fit: BoxFit.cover,),height: 20,width: 20,),
                      title: Text('Whishlist',style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WishlistPage()),

                        );

                      },
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey, thickness: 1),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.15,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    // Navigate to the respective category page
                    switch (filteredCategories[index]['name']) {
                      case 'Accessories':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AccessoriesPage()),
                        );
                        break;
                      case 'Electronics':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ElectronicsPage()),
                        );
                        break;
                      case 'Clothing':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ClothingPage()),
                        );
                        break;
                      case 'Groceries':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GroceriesPage()),
                        );
                        break;
                      case 'Books':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BooksPage()),
                        );
                        break;
                      case 'Beauty':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BeautyPage()),
                        );
                        break;
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black.withOpacity(0.6), // Always black border
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(filteredCategories[index]['image']!),
                            radius: 30,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          filteredCategories[index]['name']!,
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
            ),
          ),
        Expanded(
            child: ListView(
              children: [
                featuredSection(screenWidth, screenHeight),
                popularBrandsSection(screenWidth, screenHeight, popularBrands,Brands),
                dealsOfTheDaySection(screenWidth, screenHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget featuredSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured',
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: screenHeight * 0.25, // Adjust the height as needed
            child: PageView.builder(
              controller: _pageController,
              itemCount: featuredImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => detailPages[index]),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: screenWidth * 0.7, // Adjust the width as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(featuredImages[index]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget dealsOfTheDaySection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deals of the Day',
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('dealsoftheday').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No deals found.'));
              }

              final deals = snapshot.data!.docs.map((doc) {
                return {
                  'name': doc['name'] as String,
                  'image': doc['image'] as String,
                  'originalPrice': doc['originalprice'] as String,
                  'offerPrice': doc['offerprice'] as String,
                  'description': doc['description'] as String,
                };
              }).toList();

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  final deal = deals[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(deal: deal),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              deal['image']!,
                              width: double.infinity,
                              height: screenHeight * 0.15,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deal['name']!,
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '₹${deal['originalPrice']!}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(height: 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹${deal['offerPrice']!}',
                                      style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Consumer<WishlistProvider>(
                                      builder: (context, wishlistProvider, child) {
                                        final isInWishlist = wishlistProvider.isInWishlist(deal['name']!);
                                        return IconButton(
                                          icon: Icon(
                                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                                            color: isInWishlist ? Colors.red : Colors.grey,
                                          ),
                                          onPressed: () {
                                            wishlistProvider.toggleWishlist(
                                              deal['name']!,
                                              deal['image']!,
                                              deal['offerPrice']!,
                                              deal['description']!,
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
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
  Widget popularBrandsSection(double screenWidth, double screenHeight, List<String> popularBrands, List<Widget> brandPages) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Brands',
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: screenHeight * 0.15, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularBrands.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle brand selection
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => brandPages[index]),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.35, // Adjust the width as needed
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        popularBrands[index],
                        width: double.infinity, // Full width of the container
                        height: double.infinity, // Full height of the container
                        fit: BoxFit.cover, // Fill the container while maintaining aspect ratio
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }}
class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> deal;

  const ProductDetailsPage({Key? key, required this.deal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Set Scaffold background color to white
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white, // Set AppBar background color to white
        iconTheme: IconThemeData(color: Colors.black), // Ensure app bar icon color is black
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        deal['image'],
                        height: screenHeight * 0.5, // Adjusted image height
                        width: screenWidth * 0.9, // Adjusted image width
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    deal['name'],
                    style: GoogleFonts.nunito(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Product description will go here. Replace this with actual product details.',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        deal['offerPrice'],
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Consumer<WishlistProvider>(
                        builder: (context, wishlistProvider, child) {
                          final isInWishlist = wishlistProvider.isInWishlist(deal['name']);
                          return IconButton(
                            icon: Icon(
                              isInWishlist ? Icons.favorite : Icons.favorite_border,
                              color: isInWishlist ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              wishlistProvider.toggleWishlist(
                                deal['name'],
                                deal['image'],
                                deal['offerPrice'],
                                'Description of ${deal['name']}', // Replace with actual description
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
          ),
          Container(
            width: double.infinity, // Full width button
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                addToCart(context, deal); // Call function to add to cart
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded button
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
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
    );
  }

  void addToCart(BuildContext context, Map<String, dynamic> deal) {
    // Access CartProvider instance
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Add item to cart
    cartProvider.addToCart(
      CartItem(
        name: deal['name'],
        price: double.parse(deal['offerPrice'].replaceAll('₹', '').replaceAll(',', '')), // Example: ₹1,000 -> 1000.0
        quantity: 1, // Initial quantity
        imagePath: deal['image'],
      ),
    );

    // Show confirmation or perform any other action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deal['name']} added to cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}