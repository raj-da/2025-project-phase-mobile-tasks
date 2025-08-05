import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/cards.dart';
import '../bloc/product_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/icons.dart';
import '../widgets/text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double homePagePadding = 24.0;
  double profilePictureHeight = 60.0;
  double profilePictureWidth = 60.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(homePagePadding),
        child: Column(
          children: [

            // Available product and search Icon
            //todo: configure square Icon box size
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(text: 'Available Products', size: 28, isBold: true),

                squareIcon(icon: Icons.search, size: 23),
              ],
            ),

            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  // case 1: Loading state
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // case 2: Loaded State
                  if (state is LoadedAllProductState) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return Center(
                        child: customText(
                          text: 'No products yet. Add one!',
                          size: 30,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: card(
                            context,
                            product: product,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/details',
                                arguments: product,
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  // case 3: Error state
                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }

                  // case 4: success messge
                  if (state is ProductSuccess) {
                    return const Center(child: Text('Product created successfuly'));
                  }
                  // Default/Initial state
                  return Center(child: customText(text: 'Welcome!', size: 40));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProductBloc>().add(ToCreateEvent());
          Navigator.pushNamed(context, '/addUpdate');
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
    );
  }
}
