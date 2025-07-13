import 'dart:io';

import 'product_manager.dart';

void printMenu() {
  print("1. Add a new Product");
  print("2. View all Products");
  print("3. View a specific Product");
  print("4. Edit a product");
  print("5. Delete a specific product");
  print("6. Exit the program");
}

void main() {
  ProductManager productManager = ProductManager();

  int choice;
  while (true) {
    printMenu();
    stdout.write("Enter a number (default is 6): ");
    choice = int.tryParse(stdin.readLineSync() ?? '6') ?? 6;

    switch (choice) {
      case 1:
        stdout.write("Product name: ");
        String name = stdin.readLineSync()!;

        stdout.write("Product description: ");
        String description = stdin.readLineSync()!;

        stdout.write("Product Price: ");
        double price =
            double.tryParse((stdin.readLineSync() ?? '0.00')) ?? 0.00;

        productManager.addProduct(
          name: name,
          description: description,
          price: price,
        );
        break;
      case 2:
        productManager.viewProducts();
        break;
      case 3:
        stdout.write("Product name: ");
        String name = stdin.readLineSync()!;
        productManager.viewProduct(name);
        break;
      case 4:
        stdout.write("Protuct name");
        String prevName = stdin.readLineSync()!;

        stdout.write("new Product name: ");
        String name = stdin.readLineSync()!;

        stdout.write("new Product description: ");
        String description = stdin.readLineSync()!;

        stdout.write("new Product Price: ");
        double price =
            double.tryParse((stdin.readLineSync() ?? '0.00')) ?? 0.00;

        productManager.editProduct(
          prevName: prevName,
          name: name,
          description: description,
          price: price,
        );
        break;
      case 5:
        stdout.write("Product name: ");
        String name = stdin.readLineSync()!;
        productManager.removeProduct(name);
        break;
      case 6:
        exit(0);
      default:
        print("Please Enter a valid number");
    }
  }
}
