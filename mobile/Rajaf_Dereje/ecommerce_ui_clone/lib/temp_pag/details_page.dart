// import 'package:flutter/material.dart';
// import '../constants/product_model.dart';
// import '../widgets/Icons.dart';
// import '../widgets/text.dart';

// class DetailsPage extends StatefulWidget {
//   const DetailsPage({super.key});

//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//   // This function handles the navigation AND the result
//   void _navigateToUpdatePage(Product productToEdit) async {
//     // 1. Await the result from the ADD/UPDATE page
//     final updatedProduct =
//         await Navigator.pushNamed(
//               context,
//               '/addUpdate',
//               arguments: productToEdit,
//             )
//             as Product?;
//     // 2. If we got an updated product, pop this DetailsPage
//     //    and pass the result back to the HomePage.
//     if (updatedProduct != null && mounted) {
//       Navigator.pop(context, updatedProduct);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = ModalRoute.of(context)!.settings.arguments as Product;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: ListView(
//           children: [
//             // product image and return icon
//             Stack(
//               children: [
//                 // product Image
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
//                   child: Image.file(
//                     product.image,
//                     height: 400,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),

//                 // return Icon
//                 Positioned(
//                   top: 18.0,
//                   left: 18.0,
//                   child: circleIcon(
//                     context: context,
//                     icon: Icons.arrow_back_ios_new,
//                     borderColor: Colors.white,
//                     iconColor: const Color.fromARGB(255, 11, 114, 199),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),
//             // Product name and price section
//             Padding(
//               padding: const EdgeInsets.all(23.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       customText(
//                         text: 'Color white',
//                         size: 15,
//                         color: const Color.fromARGB(255, 167, 162, 162),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, color: Colors.amber),
//                           customText(
//                             text: '(4.0)',
//                             size: 18,
//                             color: const Color.fromARGB(255, 167, 162, 162),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       customText(
//                         text: product.name,
//                         size: 28,
//                         color: const Color.fromARGB(255, 78, 75, 75),
//                         isBold: true,
//                       ),
//                       customText(
//                         text: '\$${product.price}',
//                         size: 22,
//                         color: const Color.fromARGB(255, 49, 48, 48),
//                       ),
//                     ],
//                   ),

//                   customText(
//                     text: 'Size:',
//                     size: 28,
//                     isBold: true,
//                     color: const Color.fromARGB(255, 111, 110, 110),
//                   ),
//                 ],
//               ),
//             ),

//             // size selection section
//             SizedBox(
//               height: 70,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   size(size: '39'),
//                   size(size: '40'),
//                   size(
//                     size: '41',
//                     backGroundColor: Colors.deepPurple,
//                     textColor: Colors.white,
//                   ),
//                   size(size: '42'),
//                   size(size: '43'),
//                   size(size: '44'),
//                   size(size: '45'),
//                   size(size: '46'),
//                   size(size: '47'),
//                   size(size: '48'),
//                   size(size: '49'),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),
//             // description section
//             customText(
//               text: product.description,
//               size: 20,
//               color: Colors.grey,
//               isBold: true,
//             ),

//             // button section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // delete button
//                 SizedBox(
//                   height: 50,
//                   width: 200,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       side: const BorderSide(color: Colors.red),
//                     ),

//                     onPressed: () {
//                       product.delete =
//                           true; // Set delete property to notify home page to delete it
//                       Navigator.pop(context, product);
//                     },
//                     child: Center(
//                       child: customText(
//                         text: 'DELETE',
//                         size: 22,
//                         color: Colors.red,
//                         isBold: true,
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 50,
//                   width: 200,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       backgroundColor: Colors.deepPurple,
//                     ),

//                     onPressed: () {
//                       // Call our navigation function
//                       _navigateToUpdatePage(product);
//                     },
//                     child: Center(
//                       child: customText(
//                         text: 'UPDATE',
//                         size: 22,
//                         color: Colors.white,
//                         isBold: true,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Size selectin widget
// Widget size({
//   required String size,
//   Color backGroundColor = Colors.white,
//   Color textColor = Colors.black,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: backGroundColor,
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: const [
//         BoxShadow(
//           color: Color.fromARGB(66, 233, 230, 230),
//           blurRadius: 6,
//           offset: Offset(0, 3),
//           spreadRadius: 0.5,
//         ),
//       ],
//     ),
//     margin: const EdgeInsets.symmetric(horizontal: 8),
//     width: 70,
//     // padding: EdgeInsets.symmetric(horizontal: 26),
//     child: Center(
//       child: customText(text: size, size: 32, color: textColor),
//     ),
//   );
// }
