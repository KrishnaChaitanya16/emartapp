import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenHeight;
  final double screenWidth;
  final bool showLeading;

  CustomAppBar({required this.screenHeight, required this.screenWidth, this.showLeading = true});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
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
          leading: showLeading
              ? Builder(
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
          )
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.1);
}
