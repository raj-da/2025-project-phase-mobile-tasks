import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/sign_up_page.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/add_update_page.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ProductBloc>()..add(LoadAllProductEvent()),),
        BlocProvider(create: (context) => di.sl<AuthBloc>(),)
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          '/addUpdate': (context) => const AddUpdatePage(),
          '/details': (context) => const DetailsPage(),
          '/login': (context) => const LoginPage(),
          '/signUp': (context) => const SignUpPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
