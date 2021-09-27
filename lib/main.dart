import 'package:flutter/material.dart';
import 'package:flutter_examples/screens/dispatcher_screen.dart';
import 'package:flutter_examples/screens/provider/classes/counter.dart';
import 'package:flutter_examples/screens/provider/classes/future.dart';
import 'package:flutter_examples/screens/provider/classes/slider.dart';
import 'package:flutter_examples/screens/provider/provider_example.dart';
import 'package:flutter_examples/screens/provider_list/models/cart.dart';
import 'package:flutter_examples/screens/provider_list/models/product.dart';
import 'package:provider/provider.dart';

import 'global/routes.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (_) => ProductModel()),
          ChangeNotifierProxyProvider<ProductModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, products, cart) {
              if (cart == null) throw ArgumentError.notNull('cart');
              cart.products = products;
              return cart;
            },
          ),                                  ],
        child: MaterialApp(
      title: 'Flutter Demo',
      routes: {
        Routes.providerExample: (context) => ProviderExampleScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DispatcherScreen(),
    ));
  }
}
