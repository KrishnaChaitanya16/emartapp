import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Define categories
  final List<String> categories = [
    'Featured'
    'Electronics',
    'Clothing',
    'Groceries',
    'Books',

  ];

  // Track selected category
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1), // Adjust the height as needed
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.03), // Adjust the top padding as needed
          child: AppBar(
            backgroundColor: Colors.white,
            title: Container(
              height: screenHeight * 0.05, // Adjust the height as needed
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
                  // Action for cart button
                  print('Cart icon pressed');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'lib/icons/bag.png', // Replace with your actual path to the bag.png icon
                    width: 24, // Adjust size as needed
                    height: 24, // Adjust size as needed
                    color: Colors.black,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/icons/shopping-bag.png', // Replace with your actual path to the shopping bag icon
                      width: screenWidth * 0.1, // Adjust size as needed
                      height: screenWidth * 0.1, // Adjust size as needed
                      color: Colors.black,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 8), // Add spacing between icon and text
                    Text(
                      'Shopeez.',
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.08, // Adjust size as needed
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontStyle: FontStyle.italic, // Slanting effect
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
                        // Navigate to home
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        // Navigate to profile
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                      onTap: () {
                        // Navigate to settings
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout', style: GoogleFonts.nunito(fontSize: screenWidth * 0.045)),
                onTap: () {
                  // Perform logout
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
            height: screenHeight * 0.06, // Adjust the height as needed
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
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? Colors.black
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      categories[index],
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.04,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Home Page Content',
                style: GoogleFonts.nunito(fontSize: screenWidth * 0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
