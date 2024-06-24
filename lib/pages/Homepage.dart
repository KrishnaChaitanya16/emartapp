import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import the respective category pages
import 'package:emartapp/pages/Accessoriespage.dart';
import 'package:emartapp/pages/Beautypage.dart';
import 'package:emartapp/pages/BooksPage.dart';
import 'package:emartapp/pages/Clothingpage.dart';
import 'package:emartapp/pages/Electronicspage.dart';
import 'package:emartapp/pages/Groceriespage.dart';

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
    {'name': 'Beauty', 'image': 'assets/beauty.jpeg'}
  ];

  int selectedIndex = 0;

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

  late PageController _pageController;
  late Timer _timer;

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
                  print('Cart icon pressed');
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
                      leading: Icon(Icons.home),
                      title: Text('Home', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
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
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    // Navigate to the respective category page
                    switch (categories[index]['name']) {
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
                              color: selectedIndex == index ? Colors.black : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(categories[index]['image']!),
                            radius: 30,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          categories[index]['name']!,
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: selectedIndex == index ? Colors.black : Colors.grey,
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
                featuredSection(screenWidth, screenHeight,),
                popularBrandsSection(screenWidth, screenHeight, popularBrands),
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
    // Mock data for deals (replace with actual data model if needed)
    final List<Map<String, dynamic>> deals = [
      {
        'name': 'Iphone 15 Pro Max', // Replace with actual product name
        'image': 'assets/deal1.jpeg', // Replace with actual asset path
        'originalPrice': '\₹1,48,900', // Replace with actual original price
        'offerPrice': '\₹1,39,900', // Replace with actual offer price
      },
      {
        'name': 'Stylish Shirt', // Replace with actual product name
        'image': 'assets/deal2.png', // Replace with actual asset path
        'originalPrice': '\₹1,999', // Replace with actual original price
        'offerPrice': '\₹999', // Replace with actual offer price
      },
      {
        'name': 'Nykaa Lipstick', // Replace with actual product name
        'image': 'assets/deal3.jpeg', // Replace with actual asset path
        'originalPrice': '\₹299', // Replace with actual original price
        'offerPrice': '\₹199', // Replace with actual offer price
      },
      {
        'name': 'Nike Jordan', // Replace with actual product name
        'image': 'assets/deal4.png', // Replace with actual asset path
        'originalPrice': '\₹6,999', // Replace with actual original price
        'offerPrice': '\₹4,999', // Replace with actual offer price
      },
    ];

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
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.8, // Adjust aspect ratio as needed
            ),
            itemCount: deals.length,
            itemBuilder: (context, index) {
              return Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        deals[index]['image'],
                        width: double.infinity,
                        height: screenHeight * 0.15, // Adjust height as needed
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deals[index]['name'],
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            deals[index]['originalPrice'],
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            deals[index]['offerPrice'],
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }



  Widget popularBrandsSection(double screenWidth, double screenHeight, List<String> popularBrands) {
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
                    print('Brand tapped: ${popularBrands[index]}');
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
  }


  Widget groceriesSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Groceries',
            style: GoogleFonts.nunito(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: screenHeight * 0.2, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text('Groceries Content')),
          ),
        ],
      ),
    );
  }}

