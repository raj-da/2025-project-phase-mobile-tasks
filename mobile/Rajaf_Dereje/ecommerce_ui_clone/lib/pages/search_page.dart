import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    SizedBox(width: 12),
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
                SizedBox(height: 20),

                // Product Card
                card(),
                SizedBox(height: 20),
                card(),
                SizedBox(height: 20),

                // Filter section
                customText(text: "Category", size: 25),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                customText(text: "Price", size: 22),
                Slider(
                  value: 50,
                  max: 100,
                  activeColor: Colors.deepPurple,
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("Add Pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("APPLY", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customText({
  required String text,
  required double size,
  Color color = const Color.fromARGB(255, 78, 76, 76),
  bool isBold = false,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'sans-serif',
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color,
    ),
  );
}

Widget card() {
  return SizedBox(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      text: "MacAir Pro Laptop",
                      size: 28,
                      color: Color.fromARGB(255, 96, 94, 94),
                    ),
                    customText(
                      text: "\$800",
                      size: 22,
                      color: Color.fromARGB(255, 96, 94, 94),
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
