import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartapp/pages/Cartpage.dart';
import 'package:emartapp/pages/wishlistpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading address'));
          }

          var data = snapshot.data?.data();
          var address = data?['billing_address'] ?? 'Add billing address';

          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: CircleAvatar(
                  radius: screenWidth * 0.21,
                  backgroundImage: AssetImage('lib/icons/user.png'),
                  backgroundColor: Colors.grey.shade300,
                  // Replace with actual image asset or fetch from Firebase
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  user?.email ?? 'Loading...', // Display user email or a placeholder
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Billing Address Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Billing Address',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        address,
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Show a dialog for editing the address
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController streetController =
                                TextEditingController(text: address);
                                TextEditingController cityController =
                                TextEditingController();
                                TextEditingController stateController =
                                TextEditingController();
                                TextEditingController countryController =
                                TextEditingController();

                                return Dialog(
                                  backgroundColor: Colors.white, // Set background color to white
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Edit Billing Address',
                                          style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        TextField(
                                          controller: streetController,
                                          style: GoogleFonts.nunito(),
                                          decoration: InputDecoration(
                                            labelText: 'Street Address',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: cityController,
                                          style: GoogleFonts.nunito(),
                                          decoration: InputDecoration(
                                            labelText: 'City',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: stateController,
                                          style: GoogleFonts.nunito(),
                                          decoration: InputDecoration(
                                            labelText: 'State',
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          controller: countryController,
                                          style: GoogleFonts.nunito(),
                                          decoration: InputDecoration(
                                            labelText: 'Country',
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.nunito(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () async {
                                                // Update Firestore with new address
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user?.uid)
                                                    .update({
                                                  'billing_address': {
                                                    'street':
                                                    streetController.text,
                                                    'city': cityController.text,
                                                    'state':
                                                    stateController.text,
                                                    'country':
                                                    countryController.text,
                                                  },
                                                }).then((value) {
                                                  Navigator.of(context).pop();
                                                }).catchError((error) {
                                                  print(
                                                      "Failed to update address: $error");
                                                  // Handle error
                                                });
                                              },
                                              child: Text(
                                                'Save',
                                                style: GoogleFonts.nunito(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'Edit Address',
                            style: GoogleFonts.nunito(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // ListTile wrapped with Container for shadow effect
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  leading: SizedBox(
                    child: Image.asset(
                      'lib/icons/shopping-bag.png',
                      fit: BoxFit.cover,
                    ),
                    height: 25,
                    width: 25,
                  ),
                  title: Text(
                    'View Cart',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
              ),
              Divider(),
              // ListTile wrapped with Container for shadow effect
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text(
                    'View Wishlist',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishlistPage()),
                    );
                  },
                ),
              ),
              Divider(),
              // ListTile wrapped with Container for shadow effect
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.popUntil(context,
                        ModalRoute.withName('/')); // Pop all routes until reaching the login/home screen
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
