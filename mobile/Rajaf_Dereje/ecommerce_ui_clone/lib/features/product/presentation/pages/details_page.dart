import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/icons.dart';
import '../widgets/text.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double detailsPagePadding = 0;
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(detailsPagePadding),
        child: ListView(
          children: [
            // product image and return icon
            Stack(
              children: [
                // Product Image
                ClipRRect(
                  // borderRadius: const BorderRadius.vertical(
                  //   top: Radius.circular(30),
                  // ),
                  child: Image.network(
                    product.imageUrl,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // return Icon
                Positioned(
                  top: 18.0,
                  left: 18.0,
                  child: circleIcon(
                    icon: Icons.arrow_back_ios_new,
                    context: context,
                    borderColor: Colors.white,
                    iconColor: const Color.fromARGB(255, 11, 144, 199),
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 3),
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
                        text: 'Color white',
                        size: 15,
                        color: const Color.fromARGB(255, 167, 162, 162),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          customText(
                            text: ('4.0'),
                            size: 18,
                            color: const Color.fromARGB(255, 167, 162, 162),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: product.name,
                        size: 22,
                        color: const Color.fromARGB(255, 78, 75, 75),
                        isBold: true,
                      ),
                      customText(
                        text: '\$${product.price}',
                        size: 18,
                        color: const Color.fromARGB(255, 49, 48, 48),
                      ),
                    ],
                  ),

                  customText(
                    text: 'Size: ',
                    size: 25,
                    isBold: true,
                    color: const Color.fromARGB(255, 111, 110, 110),
                  ),
                ],
              ),
            ),

            // size selection section
            SizedBox(
              height: 65,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  size(size: '39'),
                  size(size: '40'),
                  size(
                    size: '41',
                    backGroundColor: Colors.deepPurple,
                    textColor: Colors.white,
                  ),
                  size(size: '42'),
                  size(size: '43'),
                  size(size: '44'),
                  size(size: '45'),
                  size(size: '46'),
                  size(size: '47'),
                  size(size: '48'),
                  size(size: '49'),
                ],
              ),
            ),

            const SizedBox(height: 13),
            customText(
              text: product.description,
              size: 20,
              color: Colors.grey,
              isBold: true,
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: () {
                        context.read<ProductBloc>().add(
                          DeleteProductEvent(product.id),
                        );
                        Navigator.pushNamed(context, '/');
                      },
                      child: Center(
                        child: customText(
                          text: 'DELETE',
                          size: 22,
                          color: Colors.red,
                          isBold: true,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // spacing between buttons
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {
                        context.read<ProductBloc>().add(
                          ToUpdateEvent(product: product),
                        );
                        Navigator.pushNamed(context, '/addUpdate');
                      },
                      child: Center(
                        child: customText(
                          text: 'UPDATE',
                          size: 22,
                          color: Colors.white,
                          isBold: true,
                        ),
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

Widget size({
  required String size,
  Color backGroundColor = Colors.white,
  Color textColor = Colors.black,
}) {
  return Container(
    decoration: BoxDecoration(
      color: backGroundColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(66, 233, 230, 230),
          blurRadius: 6,
          offset: Offset(0, 3),
          spreadRadius: 0.5,
        ),
      ],
    ),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    width: 70,
    // padding: EdgeInsets.symmetric(horizontal: 26),
    child: Center(
      child: customText(text: size, size: 32, color: textColor),
    ),
  );
}
