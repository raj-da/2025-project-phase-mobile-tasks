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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  double formInputNameSize = 13.5;
  bool _isChecked = false; // for the term and codition checkbox

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
                      controller: nameController,
                      hintText: 'ex: jon smith',
                      inputType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 10),

                    customText(text: 'Email', size: formInputNameSize),
                    const SizedBox(height: 5),
                    textInput(
                      controller: emailController,
                      hintText: 'ex: jon.smith@gmail.com',
                      inputType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 10),

                    customText(text: 'Password', size: formInputNameSize),
                    const SizedBox(height: 5),
                    // Password Field
                    textInput(
                      controller: passwordController,
                      hintText: '********',
                      inputType: TextInputType.visiblePassword,
                    ),

                    const SizedBox(height: 10),

                    customText(
                      text: 'Confirm password',
                      size: formInputNameSize,
                    ),
                    const SizedBox(height: 5),
                    // Password Field
                    textInput(
                      controller: confirmPasswordController,
                      hintText: '********',
                      inputType: TextInputType.visiblePassword,
                    ),

                    const SizedBox(height: 5,),

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
                            style: TextStyle(color: Color.fromARGB(255, 5, 5, 5), fontSize: 14),
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
