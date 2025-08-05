import 'package:flutter/material.dart';

import 'icons.dart';
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

            // notification Icon
            squareIcon(
              icon: Icons.notifications_none,
              iconColor: const Color.fromARGB(255, 90, 87, 87),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8); // KToolbarHeight is the standard AppBar height.
}
