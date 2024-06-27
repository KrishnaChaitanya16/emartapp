import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/icons/shopping-bag.png',
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              color: Colors.black,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            WidgetAndTextAnimator(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 1000),
              widget: Icon(
                Icons.shopping_bag,
                size: MediaQuery.of(context).size.width * 0.08,
                color: Colors.black,
              ),
              text: 'Shopeez.',
              textStyle: GoogleFonts.nunito(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              alignment: Alignment.center,
              textPosition: TextPosition.bottom,
              textAnimationType: TextAnimationType.typer,
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }
}
