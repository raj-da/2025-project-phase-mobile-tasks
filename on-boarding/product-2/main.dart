import 'dart:io';
import 'product_manager.dart';

const String promptProductName = "Product name: ";
const String promptProductDescription = "Product description: ";
const String promptProductPrice = "Product price: ";
const String promptNewProductName = "new product name: ";
const String promptNewProductDescription = "new product description: ";
const String promptNewProductPrice = "new product price: ";

void printMenu() {
  print("\n========== Product Manager ==========");
  print("1. Add a new Product");
  print("2. View all Products");
  print("3. View a specific Product");
  print("4. Edit a product");
  print("5. Delete a specific product");
  print("6. Exit the program");
  print("=====================================");
}

String? takeInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync()?.trim();
}

String promptString(String prompt) {
  String? input = takeInput(prompt);
  while (input == null || input.isEmpty) {
    print("Warning! This section can not be empty!");
    input = takeInput(prompt);
  }
  return input;
}

double promptDouble(String prompt) {
  String? input = takeInput(prompt);
  while (input == null || double.tryParse(input) == null) {
    print("Warning! Wrong input type!");
    print("Please Enter a numerical Value");
    input = takeInput(prompt);
  }
  return double.tryParse(input)!;
}

void handleMenuChoice(int choice, ProductManager pm) {
  switch (choice) {
    case 1:
      String name = promptString(promptProductName);
      String description = promptString(promptProductDescription);
      double price = promptDouble(promptProductPrice);

      pm.addProduct(name: name, description: description, price: price);
      break;
    case 2:
      pm.viewProducts();
      break;
    case 3:
      String name = promptString(promptProductName);
      pm.viewProduct(name);
      break;
    case 4:
      String prevName = promptString(promptProductName);
      String name = promptString(promptNewProductName);
      String description = promptString(promptNewProductDescription);
      double price = promptDouble(promptNewProductPrice);

      pm.editProduct(
        prevName: prevName,
        name: name,
        description: description,
        price: price,
      );
      break;
    case 5:
      String name = promptString(promptProductName);
      pm.removeProduct(name);
      break;
    case 6:
      print("Thank you for using the Product Manager. Goodbye!");
      exit(0);
    default:
      print("Please Enter a valid number");
  }
}

void main() {
  ProductManager productManager = ProductManager();
  int choice;

  while (true) {
    printMenu();
    stdout.write("Choose an option (1-6, default is 6 to exit): ");
    choice = int.tryParse(stdin.readLineSync() ?? '6') ?? 6;
    handleMenuChoice(choice, productManager);
  }
}
