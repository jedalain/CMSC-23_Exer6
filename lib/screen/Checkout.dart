import 'package:flutter/material.dart';
import 'package:my_app/model/Item.dart';
import 'package:my_app/provider/shoppingcart_provider.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    // get items and total price
    List<Item> productsInCart = context.watch<ShoppingCart>().cart;
    double cartTotal = context.watch<ShoppingCart>().cartTotal;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),

      body: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: productsInCart.length, // get number of products in cart

                  itemBuilder: (BuildContext context, int index) {
                    var productName = productsInCart[index].name;
                    var productPrice = productsInCart[index].price;

                    return ListTile(
                      leading: const Icon(Icons.star),
                      
                      title: Text(productName),

                      trailing: Text("$productPrice")
                    );
                  }
                ) 
              ),

              Text(
                "Your total is: $cartTotal",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                ),
              ),
              
              // checkout button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // close dialog box
                      Navigator.of(context).pop(); // go back to catalog
                      context.read<ShoppingCart>().removeAll(); // empty cart
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Payment successful."),
                          duration: Duration(seconds: 1, milliseconds: 100),
                        ),
                      );
                    },
                    
                    child: const Text("Confirm")
                  )
                ],
              ),
            ],
          )
        )
    );
  }
}