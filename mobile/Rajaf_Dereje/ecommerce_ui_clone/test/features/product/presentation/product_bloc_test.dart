// import 'package:dartz/dartz.dart';
// import 'package:ecommerce_ui_clone/core/error/failures.dart' show ServerFailure;
// import 'package:ecommerce_ui_clone/features/product/domain/entities/product.dart';
// import 'package:ecommerce_ui_clone/features/product/domain/usecases/create_product_usecase.dart';
// import 'package:ecommerce_ui_clone/features/product/domain/usecases/delete_product_usecase.dart';
// import 'package:ecommerce_ui_clone/features/product/domain/usecases/update_product_usecase.dart';
// import 'package:ecommerce_ui_clone/features/product/domain/usecases/view_all_products_usecase.dart';
// import 'package:ecommerce_ui_clone/features/product/domain/usecases/view_product_usecase.dart';
// import 'package:ecommerce_ui_clone/features/product/presentation/bloc/product_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:bloc_test/bloc_test.dart';

// import 'product_bloc_test.mocks.dart';

// @GenerateMocks([
//   ViewAllProductsUsecase,
//   ViewProductUsecase,
//   CreateProductUsecase,
//   UpdateProductUsecase,
//   DeleteProductUsecase,
// ])
// abstract class Failure extends Equatable {
//   const Failure([List properties = const <dynamic>[]]);
// }

// // class ServerFailure extends Failure {
// //   @override
// //   List<Object> get props => [];
// // }

// // class Right<R> {
// //   final R value;
// //   Right(this.value);
// // }

// // class Left<L> {
// //   final L value;
// //   Left(this.value);
// // }

// void main() {
//   late MockViewAllProductsUsecase mockViewAllProductsUsecase;
//   late MockViewProductUsecase mockViewProductUsecase;
//   late MockCreateProductUsecase mockCreateProductUsecase;
//   late MockUpdateProductUsecase mockUpdateProductUsecase;
//   late MockDeleteProductUsecase mockDeleteProductUsecase;
//   late ProductBloc productBloc;

//   // Dummy data for testing
//   final tProduct = Product(
//     name: 'Test Product',
//     price: '200',
//     category: 'Test category',
//     description: 'Test descriptioin',
//     imagePath: 'image',
//     id: '1',
//   );

//   final tProductList = [tProduct];
//   // final tFailure = ServerFailure();

//   // setUp runs before each test
//   setUp(() {
//     // Initialize the mocks
//     mockViewAllProductsUsecase = MockViewAllProductsUsecase();
//     mockViewProductUsecase = MockViewProductUsecase();
//     mockCreateProductUsecase = MockCreateProductUsecase();
//     mockUpdateProductUsecase = MockUpdateProductUsecase();
//     mockDeleteProductUsecase = MockDeleteProductUsecase();

//     // Initialize the BLoC with the mocks
//     productBloc = ProductBloc(
//       viewAllProductsUsecase: mockViewAllProductsUsecase,
//       viewProductUsecase: mockViewProductUsecase,
//       createProductUsecase: mockCreateProductUsecase,
//       updateProductUsecase: mockUpdateProductUsecase,
//       deleteProductUsecase: mockDeleteProductUsecase,
//     );
//   });

//   tearDown(() {
//     productBloc.close();
//   });

//   test('initial state should be ProdutInitial', () {
//     expect(productBloc.state, ProductInitial());
//   });

//   group('LoadAllProductEvent', () {
//     blocTest<ProductBloc, ProductState>(
//       'emits [ProductLoading, LoadedAllProductState] when data is gotten  added.',
//       build: () {
//         when(
//           mockViewAllProductsUsecase(),
//         ).thenAnswer((_) async => Right(tProductList));
//         return productBloc;
//       },
//       act: (bloc) => bloc.add(LoadAllProductEvent()),
//       expect: () => <ProductState>[
//         ProductLoading(),
//         LoadedAllProductState(tProductList),
//       ],
//       verify: (_) => verify(mockViewAllProductsUsecase()).called(1),
//     );

//     blocTest(
//       'should emit [ProductLoading, ProductError] when getting data fails',
//       build: () {
//         when(
//           mockViewAllProductsUsecase(),
//         ).thenAnswer((_) async => Left(const ServerFailure()));
//         return productBloc;
//       },

//       act: (bloc) => bloc.add(LoadAllProductEvent()),

//       expect: () => [
//         ProductLoading(),
//         ProductError('Failed to load products: Instance of \'ServerFailure\''),
//       ],
//     );
//   });

//   group('CreateAllProductEvent', () {
//     blocTest<ProductBloc, ProductState>(
//       'emits [ProductLoading, ProductLoading, LoadedAllProductState] on success.',
//       build: () {
//         when(
//           mockCreateProductUsecase(any),
//         ).thenAnswer((_) async => Right(null));
//         when(
//           mockViewAllProductsUsecase(),
//         ).thenAnswer((_) async => Right(tProductList));
//         return productBloc;
//       },
//       act: (bloc) => bloc.add(CreateProductEvent(tProduct)),
//       expect: () => <ProductState>[
//         // ProductLoading(), // From the create event handler
//         ProductLoading(), // From the subsequent LoadAllProductEvent handler
//         LoadedAllProductState(tProductList),
//       ],

//       verify: (_) {
//         verify(mockCreateProductUsecase(tProduct)).called(1);
//         verify(
//           mockViewAllProductsUsecase(),
//         ).called(1); // Verify the reload happens
//       },
//     );
//   });
// }
