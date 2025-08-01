import 'package:flutter/material.dart';
import '../../../../constants/product_model.dart';
import 'text.dart';

Widget card(
  BuildContext context, {
  required Product product,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.file(
                product.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),

              // place holder image
              // child: Image.network(
              //   "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
              //   width: double.infinity,
              //   height: 200,
              //   fit: BoxFit.cover,
              // ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: product.name,
                        size: 28,
                        color: const Color.fromARGB(255, 96, 94, 94),
                      ),
                      customText(
                        text: '\$${product.price}',
                        size: 22,
                        color: const Color.fromARGB(255, 96, 94, 94),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: 'Color white',
                        size: 15,
                        color: const Color.fromARGB(255, 167, 162, 162),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          customText(
                            text: '(4.0)',
                            size: 18,
                            color: const Color.fromARGB(255, 167, 162, 162),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
