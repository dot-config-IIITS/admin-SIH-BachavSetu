import 'package:admin/init.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel', // Replace with your app title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Change theme as desired
      ),
      home: HomePage(), // Set HomePage as the initial page
      debugShowCheckedModeBanner: false,
    );
  }
}
