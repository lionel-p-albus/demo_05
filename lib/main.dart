import 'package:demo_05/providers/cart.dart';
import 'package:demo_05/providers/products.dart';
import 'package:demo_05/screens/product_detail_screen.dart';
import 'package:demo_05/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Products()),
          ChangeNotifierProvider.value(value: Cart()),
        ],
        child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
          },
        ));
  }
}
