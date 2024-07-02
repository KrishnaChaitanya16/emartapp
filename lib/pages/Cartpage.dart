import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:emartapp/cartprovider.dart'; // Import your CartProvider

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    final totalPrice = cartProvider.getTotalPrice();

    // Format total price in Indian numbering system
    final formattedTotalPrice = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(totalPrice);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(fontSize: 24),
          ),
        ),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            child: Stack(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        cartItem.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    cartItem.name,
                    style: GoogleFonts.nunito(),
                  ),
                  subtitle: Text(
                    '₹${cartItem.price}',
                    style: GoogleFonts.nunito(),
                  ),
                  trailing: SizedBox.shrink(),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (cartItem.quantity > 1) {
                              cartProvider.decrementItem(cartItem);
                            } else {
                              cartProvider.removeFromCart(cartItem);
                            }
                          },
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${cartItem.quantity}',
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            cartProvider.incrementItem(cartItem);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: $formattedTotalPrice',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement proceed to pay functionality
                  // Navigate to payment screen or perform payment logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'Proceed to Pay',
                  style: GoogleFonts.nunito(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      )
          : null,
    );
  }
}