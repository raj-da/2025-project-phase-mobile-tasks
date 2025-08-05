part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

// The initial state, before anything has happend
final class ProductInitial extends ProductState {}

// The state while data is being fetched from the repository
class ProductLoading extends ProductState {}

// The state for insert/update/delete success
class ProductSuccess extends ProductState {}

// The state when all products have been successfully loaded
class LoadedAllProductState extends ProductState {
  final List<Product> products;

  const LoadedAllProductState(this.products);

  @override
  List<Object> get props => [products];
}

// The state when a single product has been successflly loaded.
class LoadedSingleProductState extends ProductState {
  final Product product;

  const LoadedSingleProductState(this.product);

  @override
  List<Object> get props => [product];
}

// The state when an error has occurred
class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

// when user goes to update page
class ToUpdateState extends ProductState {
  final Product product;

  const ToUpdateState(this.product);

  @override
  List<Object> get props => [product];
}

// when user goes to create page
class ToCreateState extends ProductState {}