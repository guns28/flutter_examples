import 'package:flutter/material.dart';
import 'package:flutter_examples/screens/dispatcher_screen.dart';
import 'package:flutter_examples/screens/provider/classes/counter.dart';
import 'package:flutter_examples/screens/provider/classes/future.dart';
import 'package:flutter_examples/screens/provider/classes/slider.dart';
import 'package:flutter_examples/screens/provider/provider_example.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        Routes.providerExample: (context) => ProviderExampleScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DispatcherScreen(),
    );
  }
}
