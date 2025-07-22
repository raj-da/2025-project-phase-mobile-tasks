import 'package:flutter/material.dart';
import '../constants/product_model.dart';
import '../widgets/Icons.dart';
import '../widgets/text.dart';

String description = """
A MacBook Air is a sleek and lightweight laptop renowned for its elegant design, impressive performance, and long-lasting battery life. Characterized by its slim profile and fanless build, 
the MacBook Air offers a quiet and efficient user experience, making it ideal for both productivity and portability.
It features Apple's advanced M-series chips, delivering powerful performance while maintaining energy efficiency. 
""";

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            // product image and return icon
            Stack(
              children: [
                // product Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  child: Image.file(
                    product.image,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // return Icon
                Positioned(
                  top: 18.0,
                  left: 18.0,
                  child: circleIcon(
                    context: context,
                    icon: Icons.arrow_back_ios_new,
                    borderColor: Colors.white,
                    iconColor: const Color.fromARGB(255, 11, 114, 199),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            // Product name and price section
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Color white",
                        size: 15,
                        color: Color.fromARGB(255, 167, 162, 162),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          customText(
                            text: "(4.0)",
                            size: 18,
                            color: Color.fromARGB(255, 167, 162, 162),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: product.name,
                        size: 28,
                        color: Color.fromARGB(255, 78, 75, 75),
                        isBold: true,
                      ),
                      customText(
                        text: "\$${product.price}",
                        size: 22,
                        color: Color.fromARGB(255, 49, 48, 48),
                      ),
                    ],
                  ),

                  customText(
                    text: "Size:",
                    size: 28,
                    isBold: true,
                    color: const Color.fromARGB(255, 111, 110, 110),
                  ),
                ],
              ),
            ),

            // size selection section
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  size(size: "39"),
                  size(size: "40"),
                  size(
                    size: "41",
                    backGroundColor: Colors.deepPurple,
                    textColor: Colors.white,
                  ),
                  size(size: "42"),
                  size(size: "43"),
                  size(size: "44"),
                  size(size: "45"),
                  size(size: "46"),
                  size(size: "47"),
                  size(size: "48"),
                  size(size: "49"),
                ],
              ),
            ),

            SizedBox(height: 20),
            // description section
            customText(
              text: product.description,
              size: 20,
              color: Colors.grey,
              isBold: true,
            ),

            // button section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // delete button
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: Colors.red),
                    ),

                    onPressed: () {
                      debugPrint("delete button");
                    },
                    child: Center(
                      child: customText(
                        text: "DELETE",
                        size: 22,
                        color: Colors.red,
                        isBold: true,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.deepPurple,
                    ),

                    onPressed: () {
                      debugPrint("update button");
                    },
                    child: Center(
                      child: customText(
                        text: "UPDATE",
                        size: 22,
                        color: Colors.white,
                        isBold: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Size selectin widget
Widget size({
  required String size,
  Color backGroundColor = Colors.white,
  Color textColor = Colors.black,
}) {
  return Container(
    decoration: BoxDecoration(
      color: backGroundColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(66, 233, 230, 230),
          blurRadius: 6,
          offset: Offset(0, 3),
          spreadRadius: 0.5,
        ),
      ],
    ),
    margin: EdgeInsets.symmetric(horizontal: 8),
    width: 70,
    // padding: EdgeInsets.symmetric(horizontal: 26),
    child: Center(
      child: customText(text: size, size: 32, color: textColor),
    ),
  );
}
