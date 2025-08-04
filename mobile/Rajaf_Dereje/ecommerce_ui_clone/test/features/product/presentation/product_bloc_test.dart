import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/features/product/domain/entities/product.dart';
import 'package:ecommerce_ui_clone/features/product/domain/usecases/create_product_usecase.dart';
import 'package:ecommerce_ui_clone/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:ecommerce_ui_clone/features/product/domain/usecases/update_product_usecase.dart';
import 'package:ecommerce_ui_clone/features/product/domain/usecases/view_all_products_usecase.dart';
import 'package:ecommerce_ui_clone/features/product/domain/usecases/view_product_usecase.dart';
import 'package:ecommerce_ui_clone/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([
  ViewProductUsecase,
  ViewAllProductsUsecase,
  CreateProductUsecase,
  UpdateProductUsecase,
  DeleteProductUsecase,
])
void main() {
  late ProductBloc bloc;
  late MockViewAllProductsUsecase mockViewAll;
  late MockViewProductUsecase mockViewSingle;
  late MockCreateProductUsecase mockCreate;
  late MockUpdateProductUsecase mockUpdate;
  late MockDeleteProductUsecase mockDelete;

  setUp(() {
    mockViewAll = MockViewAllProductsUsecase();
    mockViewSingle = MockViewProductUsecase();
    mockCreate = MockCreateProductUsecase();
    mockUpdate = MockUpdateProductUsecase();
    mockDelete = MockDeleteProductUsecase();

    bloc = ProductBloc(
      viewAllProductsUsecase: mockViewAll,
      viewProductUsecase: mockViewSingle,
      createProductUsecase: mockCreate,
      updateProductUsecase: mockUpdate,
      deleteProductUsecase: mockDelete,
    );
  });

  //todo change price to double
  final tProduct = const Product(
    name: 'Product 1',
    price: '100.0',
    description: 'Description',
    imageUrl: '/image1.png',
    id: '1',
  );
  final tProducts = [tProduct];

  group('LoadAllProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, LoadedAllProductState] 
      when LoadAllProductEvent is added and Usecase returns success''',
      build: () {
        when(mockViewAll()).thenAnswer((_) async => Right(tProducts));
        return bloc;
      },

      act: (bloc) => bloc.add(LoadAllProductEvent()),

      expect: () => [ProductLoading(), LoadedAllProductState(tProducts)],
      verify: (_) {
        verify(mockViewAll()).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, ProductError] 
    when LoadAllProductEven is added and Usecase return Failure''',
      build: () {
        when(
          mockViewAll(),
        ).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },

      act: (bloc) => bloc.add(LoadAllProductEvent()),

      expect: () => [
        ProductLoading(),
        ProductError(
          'Failed to load products: ${const ServerFailure().toString()}',
        ),
      ],
      verify: (_) {
        verify(mockViewAll()).called(1);
      },
    );
  }); // load all product event group

  group('GetSingleProductEvent', () {
    final tid = '1';
    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, LoadedSingleProductState] when
       GetSingleProductEvent is added and ViewProductUsecase return a success.''',
      build: () {
        when(mockViewSingle(tid)).thenAnswer((_) async => Right(tProduct));
        return bloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(id: tid)),
      expect: () => <ProductState>[
        ProductLoading(),
        LoadedSingleProductState(tProduct),
      ],

      verify: (_) {
        verify(mockViewSingle(tid)).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, ProductError] when
       GetSingleProductEvent is added and ViewProductUsecase return a Faliur.''',
      build: () {
        when(
          mockViewSingle(tid),
        ).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(id: tid)),
      expect: () => <ProductState>[
        ProductLoading(),
        ProductError(
          'Failed to load product: ${const ServerFailure().toString()}',
        ),
      ],

      verify: (_) {
        verify(mockViewSingle(tid)).called(1);
      },
    );
  }); // get single product event group

  group('CreateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, LoadedAllProductState] when 
      CreateProductEvent is added and mockCreate returns a success.''',
      build: () {
        when(mockCreate(tProduct)).thenAnswer((_) async => const Right(null));
        when(mockViewAll()).thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(tProduct)),
      expect: () => <ProductState>[
        ProductLoading(),
        LoadedAllProductState(tProducts),
      ],

      verify: (_) {
        verify(mockViewAll()).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, ProductError] when
       CreateProductEvent is added and CreateProductUsecase return a Faliur.''',
      build: () {
        when(
          mockCreate(tProduct),
        ).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(tProduct)),
      expect: () => <ProductState>[
        ProductLoading(),
        ProductError(
          'Failed to create product: ${const ServerFailure().toString()}',
        ),
      ],

      verify: (_) {
        verify(mockCreate(tProduct)).called(1);
      },
    );
  }); // create product event

  group('UpdateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, LoadedAllProductState] when 
      UpdateProductEvent is added and mockUpdate returns a success.''',
      build: () {
        when(mockUpdate(tProduct)).thenAnswer((_) async => const Right(null));
        when(mockViewAll()).thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(tProduct)),
      expect: () => <ProductState>[
        ProductLoading(),
        LoadedAllProductState(tProducts),
      ],

      verify: (_) {
        verify(mockViewAll()).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, ProductError] when
       UpdateProductEvent is added and UpdateProductUsecase return a Faliur.''',
      build: () {
        when(
          mockUpdate(tProduct),
        ).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(tProduct)),
      expect: () => <ProductState>[
        ProductLoading(),
        ProductError(
          'Failed to update product: ${const ServerFailure().toString()}',
        ),
      ],

      verify: (_) {
        verify(mockUpdate(tProduct)).called(1);
      },
    );
  }); // update product event

  group('DeleteProductEvent', () {
    final tId = '1';
    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, LoadAllProductEvent] when 
      DeleteProductEvent is added and mockDelete returns a success.''',
      build: () {
        when(mockDelete(tId)).thenAnswer((_) async => const Right(null));
        when(mockViewAll()).thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tId)),
      expect: () => <ProductState>[
        ProductLoading(),
        LoadedAllProductState(tProducts),
      ],

      verify: (_) {
        verify(mockViewAll()).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      '''emits [ProductLoading, ProductError] when
       DeleteProductEvent is added and DeleteProductUsecase return a Faliur.''',
      build: () {
        when(
          mockDelete(tId),
        ).thenAnswer((_) async => const Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tId)),
      expect: () => <ProductState>[
        ProductLoading(),
        ProductError(
          'Failed to delete product: ${const ServerFailure().toString()}',
        ),
      ],

      verify: (_) {
        verify(mockDelete(tId)).called(1);
      },
    );
  }); // delete product event group
}