import 'package:flutter/material.dart';
import 'package:my_app/model/Item.dart';
import 'package:my_app/provider/shoppingcart_provider.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    // get items and total price
    List<Item> productsInCart = context.watch<ShoppingCart>().cart;
    double cartTotal = context.watch<ShoppingCart>().cartTotal;

    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),

      body: productsInCart.isNotEmpty ? 
        // shopping cart has content/s
        Padding(
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
              ),

              Text(
                "Your current total is: $cartTotal"
              ),
            ],
          )
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
              Navigator.pushNamed(context, "/checkout")
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