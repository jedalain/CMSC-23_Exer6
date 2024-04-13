import 'package:flutter/material.dart';
import 'package:my_app/provider/shoppingcart_provider.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    // get items and total price
    double cartTotal = context.watch<ShoppingCart>().cartTotal;
    
    return AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30), // Add some padding
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Your total is: $cartTotal"),
            const Text("Thank you for shopping with us!")
          ],
        ),

        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.read<ShoppingCart>().removeAll(); // empty cart
              Navigator.of(context).pop(); // close dialog box
              Navigator.of(context).pop(); // go back to catalog
            },
            child: const Text('HOME'),
          ),
        ],
    );
  }
}