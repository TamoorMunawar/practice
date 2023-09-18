import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practice/search_provider.dart'; // Import your provider class here
import 'package:practice/ui_screen.dart'; // Import your UI screen classes here

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        // Define your app's theme here
        primarySwatch: Colors.blue,
      ),
      // Specify which class to call as your home screen
      home:
          ProductGrid(), // You can choose either ProductGrid or SearchScreen here
    );
  }
}
