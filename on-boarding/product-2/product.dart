class Product {
  String _productName;
  String _description;
  double _price;

  Product(this._productName, this._description, this._price);

  // setting up getters
  String get name => _productName;
  String get description => _description;
  double get price => _price;

  // setting up setters
  set setName(String productName) => _productName = productName;
  set setDescription(String description) => _description = description;
  set setPrice(double price) => _price = price;

}
