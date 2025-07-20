import 'package:ecommerce_ui_clone/widgets/buttons.dart';
import 'package:flutter/material.dart';
import '../widgets/cards.dart';
import '../widgets/text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new, color: Colors.deepPurple),
        title: customText(text: "Search Product", size: 22, isBold: true),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: ListView(
            children: [
              // Top search bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Lenovo',
                        suffixIcon: Icon(
                          Icons.arrow_forward,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.filter_list, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Product Card
              card(context),
              const SizedBox(height: 20),
              card(context),
              const SizedBox(height: 20),

              // Filter section
              customText(text: "Category", size: 25),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              customText(text: "Price", size: 22),
              Slider(
                value: 50,
                max: 100,
                activeColor: Colors.deepPurple,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 20),
              addUpdateButton(buttonTitle: "APPLY"),
            ],
          ),
        ),
      ),
    );
  }
}
