import 'package:flutter/material.dart';
import '../widgets/text.dart';
import '../widgets/Icons.dart';
import '../widgets/cards.dart';
import '../constants/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];

  // Central place to handle adding or updating a product
  void _handleProductResult(Product? product) {
    if (product != null) {
      setState(() {
        // If index is -1, it's a new product
        if (product.index == -1) {
          product.index = _products.length;
          _products.add(product);
        } else {
          // Otherwise, find the existing product by its index and update it
          _products[product.index] = product;
        }
      });
    }
  }

  // To navigate as well as recive product information from addUpdate page
  void _navigateAndAddProduct() async {
    final newProduct =
        await Navigator.pushNamed(context, '/addUpdate') as Product?;
    _handleProductResult(newProduct);
  }

  // Navigate to VIEW/EDIT an existing product
  void _navigateToDetails(Product product) async {
    // Await the result from the details page flow
    final updatedProduct =
        await Navigator.pushNamed(context, '/details', arguments: product) as Product?;
    _handleProductResult(updatedProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            // Profile and notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Profile and greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile picture
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 219, 219),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 60,
                      width: 60,
                    ),

                    const SizedBox(width: 10),

                    // Greetings
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date
                        customText(text: "July 19, 2025", size: 12),

                        // hello messege
                        Row(
                          children: [
                            customText(text: "Hello, ", size: 22),
                            customText(text: "Rajaf", size: 22, isBold: true),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // notification Icon
                squareIcon(
                  icon: Icons.notifications_none,
                  iconColor: const Color.fromARGB(255, 90, 87, 87),
                ),
              ],
            ),

            // space between
            const SizedBox(height: 40),

            // Available product and search Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(text: "Available Products", size: 34, isBold: true),

                squareIcon(icon: Icons.search),
              ],
            ),

            SizedBox(height: 20),

            // Products List using List.generate
            ...List.generate(
              _products.length,
              (i) => Column(
                children: [
                  card(
                    context,
                    product: _products[i],
                    onTap: () => _navigateToDetails(_products[i]),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndAddProduct,
        shape: CircleBorder(),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
    );
  }
}
