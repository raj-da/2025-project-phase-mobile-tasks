import 'package:flutter/material.dart';
import '../widgets/text.dart'; // For custom inputs
import '../widgets/buttons.dart';
import '../constants/product_model.dart';

// value variables
const double pagePadding = 24.0;

class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({super.key});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  // Global key for form
  final _formKey = GlobalKey<FormState>();

  // Form textfield controllers
  final _productName = TextEditingController();
  final _productPrice = TextEditingController();
  final _productCategory = TextEditingController();
  final _productDescription = TextEditingController();

  // for clearing the form data
  void clearForm() {
    _productName.clear();
    _productPrice.clear();
    _productCategory.clear();
    _productDescription.clear();
  }

  @override
  void dispose() {
    _productName.dispose();
    _productPrice.dispose();
    _productCategory.dispose();
    _productDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: Icon(Icons.arrow_back_ios_new, color: Colors.deepPurple),
        title: Text("Add Product"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(pagePadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input Field Input
                    imageInputField(),

                    // name input
                    customText(text: "name", size: 20),
                    textInput(controller: _productName),

                    // category input
                    customText(text: "category", size: 20),
                    textInput(controller: _productCategory),

                    // price input
                    customText(text: "price", size: 20),
                    textInput(controller: _productPrice),

                    // description input
                    customText(text: "description", size: 20),
                    textInput(controller: _productDescription, maxLines: 7),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              addUpdateButton(
                buttonTitle: "ADD",
                onpressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProduct = Product(
                      name: _productName.text,
                      price: _productPrice.text,
                      category: _productCategory.text,
                      description: _productDescription.text,
                    );
                    Navigator.pop(context, newProduct);
                  }
                },
              ),
              deleteButton(
                buttonTitle: "DELETE",
                onpressed: () {
                  setState(() {
                    clearForm();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Image input field
Widget imageInputField() {
  return Container(
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
          Text("Upload Image", style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}

// TextFormField Function
Widget textInput({
  required TextEditingController controller,
  int maxLines = 1,
  String hintText = "",
}) {
  return TextFormField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: const Color.fromARGB(255, 241, 240, 240),
    ),

    controller: controller,

    validator: (value) {
      if (value == null || value.isEmpty) {
        return "This Field can't be empty";
      }
      return null;
    },
  );
}
