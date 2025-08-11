import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/authentication/data/datasource/auth_local_data_source.dart';
import 'features/authentication/data/datasource/auth_local_data_source_impl.dart';
import 'features/authentication/data/datasource/auth_remote_data_source.dart';
import 'features/authentication/data/datasource/auth_remote_data_source_impl.dart';
import 'features/authentication/data/repository/auth_repository_impl.dart';
import 'features/authentication/domain/repository/auth_repository.dart';
import 'features/authentication/domain/usecase/log_in_usecase.dart';
import 'features/authentication/domain/usecase/log_out_usecase.dart';
import 'features/authentication/domain/usecase/sign_up_usecase.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/chat/data/datasources/chat_remote_data_source.dart';
import 'features/chat/data/datasources/chat_remote_data_source_impl.dart';
import 'features/chat/data/datasources/chat_socket_data_source.dart';
import 'features/chat/data/datasources/chat_socket_data_source_impl.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repositories.dart';
import 'features/chat/domain/usecases/connect_socket.dart';
import 'features/chat/domain/usecases/delete_chat.dart';
import 'features/chat/domain/usecases/get_all_users.dart';
import 'features/chat/domain/usecases/get_chat_messages.dart';
import 'features/chat/domain/usecases/get_logged_user.dart';
import 'features/chat/domain/usecases/get_user_chats.dart';
import 'features/chat/domain/usecases/send_message.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/product/data/datasources/product_local_data_source.dart';
import 'features/product/data/datasources/product_local_data_source_impl.dart';
import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/datasources/product_remote_data_source_impl.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_product_usecase.dart';
import 'features/product/domain/usecases/delete_product_usecase.dart';
import 'features/product/domain/usecases/update_product_usecase.dart';
import 'features/product/domain/usecases/view_all_products_usecase.dart';
import 'features/product/domain/usecases/view_product_usecase.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //* Features - Product
  // Bloc
  sl.registerFactory(
    () => ProductBloc(
      viewAllProductsUsecase: sl(),
      viewProductUsecase: sl(),
      createProductUsecase: sl(),
      updateProductUsecase: sl(),
      deleteProductUsecase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => ViewAllProductsUsecase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //* Feature - Auth
  // bloc
  sl.registerFactory(
    () =>
        AuthBloc(logInUsecase: sl(), logOutUsecase: sl(), signUpUsecase: sl()),
  );

  // use cases
  sl.registerLazySingleton(() => LogInUsecase(repository: sl()));
  sl.registerLazySingleton(() => LogOutUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //* Feature - Chat
  // bloc
  sl.registerFactory(
    () => ChatBloc(
      getAllUsers: sl(),
      connectSocket: sl(),
      deleteChat: sl(),
      getChatMessages: sl(),
      getUserChats: sl(),
      sendMessage: sl(),
      getLoggedUser: sl()
    ),
  );

  // use cases
  sl.registerLazySingleton(() => GetAllUsers(repository: sl()));
  sl.registerLazySingleton(() => ConnectSocket(repository: sl()));
  sl.registerLazySingleton(() => DeleteChat(repository: sl()));
  sl.registerLazySingleton(() => GetChatMessages(repository: sl()));
  sl.registerLazySingleton(() => GetUserChats(repository: sl()));
  sl.registerLazySingleton(() => SendMessage(repository: sl()));
  sl.registerLazySingleton(() => GetLoggedUser(repository: sl()));


  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: sl(),
      socketDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(dio: sl(), authLocalDataSource: sl(), authRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ChatSocketDataSource>(
    () => ChatSocketDataSourceImpl(authLocalDataSource: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
