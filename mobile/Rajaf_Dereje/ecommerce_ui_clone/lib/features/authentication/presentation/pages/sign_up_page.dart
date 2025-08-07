import 'package:flutter/material.dart';

import '../widgets/buttons.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/input_field.dart';
import '../widgets/text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  double formInputNameSize = 13.5;
  bool _isChecked = false; // for the term and codition checkbox

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Create your account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(text: 'Name', size: formInputNameSize),
                    const SizedBox(height: 5),
                    // Email Field
                    textInput(
                      controller: _nameController,
                      hintText: 'ex: jon smith',
                      inputType: TextInputType.emailAddress,
                      invalidInputMessege: 'Please enter a valid name',
                    ),

                    const SizedBox(height: 10),

                    customText(text: 'Email', size: formInputNameSize),
                    const SizedBox(height: 5),
                    textInput(
                      controller: _emailController,
                      hintText: 'ex: jon.smith@gmail.com',
                      inputType: TextInputType.emailAddress,
                      invalidInputMessege: 'please enter a valid email',
                    ),

                    const SizedBox(height: 10),

                    customText(text: 'Password', size: formInputNameSize),
                    const SizedBox(height: 5),
                    // Password Field
                    textInput(
                      controller: _passwordController,
                      hintText: '********',
                      inputType: TextInputType.visiblePassword,
                      invalidInputMessege: 'Please enter a valid password',
                    ),

                    const SizedBox(height: 10),

                    customText(
                      text: 'Confirm password',
                      size: formInputNameSize,
                    ),
                    const SizedBox(height: 5),
                    // Password Field
                    textInput(
                      controller: _confirmPasswordController,
                      hintText: '********',
                      inputType: TextInputType.visiblePassword,
                      invalidInputMessege: 'Please enter your password again',
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),

                        RichText(
                          text: const TextSpan(
                            text: 'I understood the  ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 5, 5, 5),
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Term & policy',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),
              signButton(
                buttonTitle: 'SIGN IN',
                radius: 8,
                onpressed: () {
                  _formKey.currentState!.validate();
                },
              ),

              const Spacer(),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'have an account? ',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'SIGN IN',
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
    );
  }
}
