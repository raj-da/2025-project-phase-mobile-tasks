import 'pages/add_update_page.dart';
import 'pages/details_page.dart';
import 'pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/addUpdate': (context) => const AddUpdatePage(),
        '/details': (context) => const DetailsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
