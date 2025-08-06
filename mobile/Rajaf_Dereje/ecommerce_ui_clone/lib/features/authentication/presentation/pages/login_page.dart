import 'package:flutter/material.dart';

import '../../../product/presentation/widgets/text.dart';
import '../widgets/buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
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

              customText(text: 'Email', size: 15),
              const SizedBox(height: 5),
              // Email Field
              textInput(
                controller: emailController,
                hintText: 'ex: jon.smith@email.com',
                inputType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              customText(text: 'Password', size: 15),
              const SizedBox(height: 5),
              // Password Field
              textInput(
                controller: passwordController,
                hintText: '********',
                inputType: TextInputType.visiblePassword,
              ),

              const SizedBox(height: 40),

              signButton(buttonTitle: 'SIGN IN', radius: 8, onpressed: () {}),

              const Spacer(),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      print('don\'t have an account');
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}

// Your existing textInput function:
Widget textInput({
  required TextEditingController controller,
  int maxLines = 1,
  String hintText = '',
  TextInputType inputType = TextInputType.text,
}) {
  return TextFormField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: const Color.fromARGB(255, 241, 240, 240),
    ),
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "This Field can't be empty";
      }
      return null;
    },
    keyboardType: inputType,
  );
}
