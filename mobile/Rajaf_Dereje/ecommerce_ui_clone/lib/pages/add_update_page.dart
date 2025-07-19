import 'package:flutter/material.dart';

class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({super.key});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(leading: Icon(Icons.arrow_back),title: Center(child: Text("Add Product"))),

        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F0F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 50, color: Colors.grey),
                                SizedBox(height: 10),
                                Text(
                                  "Upload Image",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // name input
                        Text("name", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.orange),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            // label: Text("name"),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 240, 240),
                          ),
                        ),

                        // category input
                        Text("category", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 240, 240),
                          ),
                        ),

                        // price input
                        Text("price", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 240, 240),
                          ),
                        ),

                        // description input
                        Text("description", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          maxLines: 7,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            filled: true,
                            fillColor: const Color.fromARGB(255, 241, 240, 240),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

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
                    child: Text("ADD", style: TextStyle(color: Colors.white)),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("DELETE Pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        // width: 5.0,
                        color: Colors.red,
                      ),
                    ),
                    child: Text("DELETE", style: TextStyle(color: Colors.red)),
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
