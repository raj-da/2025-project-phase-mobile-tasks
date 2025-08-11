import 'package:flutter/material.dart';

import 'text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        // Add horizontal padding to align with typical app bar
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Profile and greeting
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // profile picture
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 219, 219),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 48,
                  width: 48,
                ),

                const SizedBox(width: 10),

                // Greetings
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: 'July 19, 2025', size: 12),

                    // hello messege
                    Row(
                      children: [
                        customText(text: 'Hello, ', size: 22),
                        customText(text: 'Rajaf', size: 22, isBold: true),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contactsPage');
                  },
                  icon: const Icon(Icons.contact_page),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chatList');
                  },
                  icon: const Icon(Icons.chat),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8); // KToolbarHeight is the standard AppBar height.
}
