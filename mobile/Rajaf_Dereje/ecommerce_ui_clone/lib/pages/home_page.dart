import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),

        body: Padding(

          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              // profile and notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                // profile and greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // profile picture
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 219, 219),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 60,
                      width: 60,
                    ),

                    SizedBox(width: 10,),

                    // greetings
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // date
                        customText(text: "July 19, 2025", size: 12),

                        // hello messege
                        Row(
                          children: [
                            customText(text: "Hello, ", size: 22),
                            customText(text: "Rajaf", size: 22, isBold: true)
                          ],
                        )
                      ],
                    )

                  ],
                ),

                // notification Icon
                squareIcon(icon: Icons.notifications_none, iconColor: const Color.fromARGB(255, 90, 87, 87))

                ],
              ),

              // space between
              SizedBox(height: 40,),

              // Available product and search Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    text: "Available Products",
                    size: 34,
                    isBold: true,
                  ),

                  squareIcon(icon: Icons.search),
                ],
              ),

              SizedBox(height: 20),

              // item cards
              card(),
              SizedBox(height: 8,),

              card(),
              SizedBox(height: 8,),

              card(),
              SizedBox(height: 8,),

              card(),
              SizedBox(height: 8,),

              card(),
              SizedBox(height: 8,),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("pressed");
          },
          shape: CircleBorder(),
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add, color: Colors.white, size: 30.0),
        ),
      ),
    );
  }
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

Widget squareIcon({
  required IconData icon,
  Color iconColor = Colors.grey,
  Color borderColor = Colors.grey,
  double size = 30,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(style: BorderStyle.solid, color: borderColor),
      borderRadius: BorderRadius.circular(12),
    ),
    child: IconButton(
      onPressed: () {
        debugPrint("Search Icon");
      },
      icon: Icon(icon, color: iconColor, size: size),
    ),
  );
}
