import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  final double screenWidth;

  CustomDrawer({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
