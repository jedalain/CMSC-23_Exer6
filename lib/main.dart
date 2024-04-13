import 'package:flutter/material.dart';
import 'package:my_app/provider/shoppingcart_provider.dart';
import 'package:my_app/screen/Checkout.dart';
import 'package:my_app/screen/MyCart.dart';
import 'package:my_app/screen/MyCatalog.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (context) => ShoppingCart()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shopping Cart",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green
        ),
      ),
      
      initialRoute: "/",
      
      routes: {
        "/catalog": (context) => const MyCatalog(),
        "/cart": (context) => const MyCart(),
        "/checkout": (context) => const Checkout()
      },

      home: const MyCatalog(),
    );
  }
}