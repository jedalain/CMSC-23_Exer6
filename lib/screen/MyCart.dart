import 'package:flutter/material.dart';
import 'package:my_app/model/Item.dart';
import 'package:my_app/provider/shoppingcart_provider.dart';
import 'package:my_app/screen/Checkout.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    // get items added by user in the shopping cart
    List<Item> productsInCart = context.watch<ShoppingCart>().cart;
    
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),

      body: productsInCart.isNotEmpty ? 
        // shopping cart has content/s
        ListView.builder(
          itemCount: productsInCart.length, // get number of products in cart

          itemBuilder: (BuildContext context, int index) {
            var productName = productsInCart[index].name;
            var productPrice = productsInCart[index].price;

            return ListTile(
              leading: const Icon(Icons.all_inbox_sharp),
              
              title: Text("$productName - $productPrice"),

              trailing: TextButton(
                child: const Icon(Icons.delete),

                onPressed: () {
                  context
                    .read<ShoppingCart>()
                    .removeItem(productName);
                  
                  setState(() {
                      context.read<ShoppingCart>().removeItem(productName);
                    });
                    
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$productName was removed from you cart."),
                    duration: const Duration(seconds: 1, milliseconds: 100),
                    ),
                  );
                },
              ),
            );
          }
        )
        :
        // shopping cart is empty
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Shopping cart is empty."),
              TextButton(
                onPressed: () { Navigator.pop(context); }, 
                child: const Text("Go to catalog")
              )
            ],
          ),
        ), 

        floatingActionButton: 
        // checkout button
        FloatingActionButton(
          child: const Icon(Icons.shopping_cart_checkout),

          onPressed: () {
            productsInCart.isNotEmpty ?
              // go to checkout
              showDialog(
                context: context, builder: (BuildContext context) {
                  return Checkout();
                }
              )
              // Navigator.pushNamed(context, "/checkout")
            :
              // show warning message
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text("Add products to proceed to checkout"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
          },
        )
    );
  }
}