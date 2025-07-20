import 'package:ecommerce_ui_clone/pages/add_update_page.dart';
import 'package:ecommerce_ui_clone/pages/details_page.dart';
import 'package:ecommerce_ui_clone/pages/home_page.dart';
import 'package:ecommerce_ui_clone/pages/search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
