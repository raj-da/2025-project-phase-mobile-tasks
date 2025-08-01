part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  /*
  @override List<Object> get props => [];: This is the core of Equatable. 
  You list all the properties of the class that should be used for comparison.
   The base class has none, but the subclasses will.
  */
  @override
  List<Object> get props => [];
}

// Event to load all products
class LoadAllProductEvent extends ProductEvent {}

// Event to get a single product by its ID
class GetSingleProductEvent extends ProductEvent {
  final String id;

  const GetSingleProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}

// Event to create a new product
class CreateProductEvent extends ProductEvent {
  final Product product;

  const CreateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

// Event to update an existing product
class UpdateProductEvent extends ProductEvent {
  final Product product;

  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

// Event to delete a product by its ID
class DeleteProductEvent extends ProductEvent {
  final String id;

  const DeleteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}
