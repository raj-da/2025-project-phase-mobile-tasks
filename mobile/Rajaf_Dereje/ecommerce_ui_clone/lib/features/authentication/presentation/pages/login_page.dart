import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/presentation/widgets/text.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/buttons.dart';
import '../widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  double formInputTypeSize = 15;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDialogOpen = false;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading && !isDialogOpen) {
          isDialogOpen = true;
          // await showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (_) => const Center(child: CircularProgressIndicator()),
          // );
          print('Auth Loading state');
        } else if (state is AuthAuthenticated || state is AuthError) {
          if (isDialogOpen) {
            // Navigator.of(context, rootNavigator: true).pop(); // close dialog
            isDialogOpen = false;
          }

          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.messege)));
          }
        }
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 80),

                // Logo
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.deepPurple.shade700),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Text(
                      'ECOM',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  'Sign into your account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(text: 'Email', size: formInputTypeSize),
                      const SizedBox(height: 5),
                      // Email Field
                      textInput(
                        controller: _emailController,
                        hintText: 'ex: jon.smith@email.com',
                        inputType: TextInputType.emailAddress,
                        invalidInputMessege: 'Please enter valid email',
                      ),

                      const SizedBox(height: 20),

                      customText(text: 'Password', size: formInputTypeSize),
                      const SizedBox(height: 5),
                      // Password Field
                      textInput(
                        controller: _passwordController,
                        hintText: '********',
                        inputType: TextInputType.visiblePassword,
                        invalidInputMessege: 'Please enter valid password',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                signButton(
                  buttonTitle: 'SIGN IN',
                  radius: 8,
                  onpressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        LoginRequested(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    }
                  },
                ),

                const Spacer(),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signUp');
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'SIGN UP',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
