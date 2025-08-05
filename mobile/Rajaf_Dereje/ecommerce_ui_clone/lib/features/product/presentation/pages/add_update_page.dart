import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/product_input_converter.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/buttons.dart';
import '../widgets/text.dart';

class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({super.key});

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  // Global Key for the form
  final _formKey = GlobalKey<FormState>();

  // Form textfield controllers
  final _productName = TextEditingController();
  final _productId = TextEditingController();
  final _productPrice = TextEditingController();
  final _productDescription = TextEditingController();

  // To store the selected image file
  String? _selectedImageUrl;

  Product? productToEdit;

  double pagePadding = 20.0;
  bool _isFirstTime = true;
  bool _isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // only set once
    if (_isFirstTime) {
      productToEdit ??= ModalRoute.of(context)!.settings.arguments as Product?;
      if (productToEdit != null) {
        _fillForm();
        _isEditing = true;
      }
      _isFirstTime = false;
    }
  }

  // To fill the form field if we're editing a product
  void _fillForm() {
    _productName.text = productToEdit!.name;
    _productId.text = productToEdit!.id;
    _productDescription.text = productToEdit!.description;
    _productPrice.text = productToEdit!.price.toString();
    _selectedImageUrl = productToEdit!.imageUrl;
  }

  // for clearing the form data
  void clearForm() {
    _productName.clear();
    _productPrice.clear();
    _productPrice.clear();
    _productDescription.clear();
    setState(() {
      _selectedImageUrl = null;
    });
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImageUrl = pickedFile.path;
      });
    }
  }

  @override
  void dispose() {
    _productName.dispose();
    _productPrice.dispose();
    _productId.dispose();
    _productDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<ProductBloc>().add(LoadAllProductEvent());
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        // leading: Icon(Icons.arrow_back_ios_new, color: Colors.deepPurple),
        title: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ToCreateState) {
              return const Text('Add Product');
            } else {
              return const Text('Update Product');
            }
          },
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(pagePadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Field Input
                    imageInputField(
                      imagePath: _selectedImageUrl,
                      ontap: _pickImage,
                    ),

                    customText(text: 'name', size: 20),
                    textInput(controller: _productName),

                    // category input
                    customText(text: 'id', size: 20),
                    textInput(controller: _productId),

                    // price input
                    customText(text: 'price', size: 20),
                    textInput(
                      controller: _productPrice,
                      inputType: const TextInputType.numberWithOptions(),
                    ),

                    // description input
                    customText(text: 'description', size: 20),
                    textInput(controller: _productDescription, maxLines: 7),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ToCreateState) {
                    return Column(
                      children: [
                        addUpdateButton(
                          buttonTitle: 'Add',
                          onpressed: () {
                            if (_formKey.currentState!.validate() &&
                                _selectedImageUrl != null) {
                              //! Add error handling and pop up messege for it
                              final result = ProductInputConverter()
                                  .convertFormToProduct(
                                    name: _productName.text,
                                    description: _productDescription.text,
                                    priceStr: _productPrice.text,
                                    imageUrl: _selectedImageUrl!,
                                    id: _productId.text,
                                  );

                              result.fold((failure) {}, (product) {
                                context.read<ProductBloc>().add(
                                  CreateProductEvent(product),
                                );
                                Navigator.pop(context, product);
                              });
                            } else {
                              //! Add pop up messege
                            }
                          },
                        ),

                        addUpdateButton(
                          buttonTitle: 'Clear',
                          onpressed: () {
                            clearForm();
                          },
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        addUpdateButton(
                          buttonTitle: 'Update',
                          onpressed: () {
                            if (_formKey.currentState!.validate() &&
                                _selectedImageUrl != null) {
                              //! Add error handling and pop up messege for it
                              final newProduct = ProductInputConverter()
                                  .convertFormToProduct(
                                    name: _productName.text,
                                    description: _productDescription.text,
                                    priceStr: _productPrice.text,
                                    imageUrl: _selectedImageUrl!,
                                    id: _productId.text,
                                  );

                              Navigator.pop(context, newProduct);
                            } else {
                              //! Add pop up messege
                            }
                          },
                        ),

                        deleteButton(buttonTitle: 'DELETE', onpressed: () {}),
                      ],
                    );
                  }
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
Widget imageInputField({
  required String? imagePath,
  required VoidCallback ontap,
}) {
  Widget? backgroundImage;

  if (imagePath != null) {
    if (imagePath.startsWith('http')) {
      backgroundImage = Image.network(imagePath, fit: BoxFit.cover);
    } else {
      backgroundImage = Image.file(File(imagePath), fit: BoxFit.cover);
    }
  }

  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: imagePath == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Upload Image', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: backgroundImage,
            ), // Don't show the icon and text when an image is selected
    ),
  );
}

// TextFormField Function
Widget textInput({
  required TextEditingController controller,
  int maxLines = 1,
  String hintText = '',
  TextInputType inputType = TextInputType.text,
}) {
  return TextFormField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
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
    keyboardType: inputType,
  );
}
