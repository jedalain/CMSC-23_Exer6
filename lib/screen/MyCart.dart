import 'package:flutter/material.dart';
import 'package:my_app/model/Item.dart';
import 'package:my_app/provider/shoppingcart_provider.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCartState();
}

class _MyCartState extends State<MyCatalog> {
  @override
  Widget build(BuildContext context) {
    // get items added by user in the shopping cart
    List<Item> productsInCart = context.watch<ShoppingCart>().cart;
    
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),

      body: productsInCart.isNotEmpty ? 
        // shopping cart has content/s
        ListView.builder(
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
        const Text("Shopping cart is empty."),

        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.storefront),
          onPressed: () {
            Navigator.pushNamed(context, "/catalog");
          },
        ),
    );
  }
}