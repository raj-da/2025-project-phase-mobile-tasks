import 'package:flutter/material.dart';
import '../widgets/text.dart';
import '../widgets/Icons.dart';
import '../widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    
            // item cards
            card(),
            const SizedBox(height: 8),
            card(),
            const SizedBox(height: 8),
            card(),
            const SizedBox(height: 8),
            card(),
            const SizedBox(height: 8),
            card(),
            const SizedBox(height: 8),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint("floating button"),
        shape: CircleBorder(),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
    );
  }
}
