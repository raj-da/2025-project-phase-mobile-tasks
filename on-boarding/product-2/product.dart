class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String getName() {
    return this._name;
  }

  String getDescription() {
    return this._description;
  }

  double getPrice() {
    return this._price;
  }

  void setName(String name) {
    this._name = name;
  }

  void setDescription(String description) {
    this._description = description;
  }

  void setPrice(double price) {
    this._price = price;
  }
}
