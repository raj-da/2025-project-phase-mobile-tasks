import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../../domain/usecases/view_all_products_usecase.dart';
import '../../domain/usecases/view_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Use cases are dependencies of the Bloc
  final ViewAllProductsUsecase viewAllProductsUsecase;
  final ViewProductUsecase viewProductUsecase;
  final CreateProductUsecase createProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ProductBloc({
    required this.viewAllProductsUsecase,
    required this.viewProductUsecase,
    required this.createProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
  }) : super(ProductInitial()) { // Set the initial state
    // Register event handlers for each event
    on<LoadAllProductEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  // Handler for loading all products
  void _onLoadAllProducts(LoadAllProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final failureOrProducts = await viewAllProductsUsecase();
    failureOrProducts.fold(
      (failure) => emit(ProductError('Failed to load products: ${failure.toString()}')),
      (products) => emit(LoadedAllProductState(products)),
    );
  }

  // Handler for getting a single product
  void _onGetSingleProduct(GetSingleProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final failureOrProduct = await viewProductUsecase(event.id);
    failureOrProduct.fold(
      (failure) => emit(ProductError('Failed to load product: ${failure.toString()}')),
      (product) => emit(LoadedSingleProductState(product!)), // Assuming product is never null on success
    );
  }

  // Handler for creating a product
  void _onCreateProduct(CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final failureOrSuccess = await createProductUsecase(event.product);
    failureOrSuccess.fold(
      (failure) => emit(ProductError('Failed to create product: ${failure.toString()}')),
      (_) => add(LoadAllProductEvent()), // On success, reload the product list
    );
  }

  // Handler for updating a product
  void _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final failureOrSuccess = await updateProductUsecase(event.product);
    failureOrSuccess.fold(
      (failure) => emit(ProductError('Failed to update product: ${failure.toString()}')),
      (_) => add(LoadAllProductEvent()), // On success, reload the product list
    );
  }

  // Handler for deleting a product
  void _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final failureOrSuccess = await deleteProductUsecase(event.id);
    failureOrSuccess.fold(
      (failure) => emit(ProductError('Failed to delete product: ${failure.toString()}')),
      (_) => add(LoadAllProductEvent()), // On success, reload the product list
    );
  }
}
