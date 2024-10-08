import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/login_singup_button.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? conformPasswordController;
  TextEditingController? nameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Header
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Create your new account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 60),
                // Full Name field
                InputField(
                    controller: nameController,
                    isObsecure: false,
                    prefixIcon: Icons.person,
                    label: 'Full name',
                    suffixIcon: null),
                const SizedBox(height: 15),
                // Email field
                InputField(
                    controller: emailController,
                    isObsecure: false,
                    prefixIcon: Icons.email,
                    label: 'Email',
                    suffixIcon: null),
                const SizedBox(height: 15),
                // Password field

                InputField(
                  controller: passwordController,
                  isObsecure: !_isPasswordVisible,
                  prefixIcon: Icons.lock,
                  label: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                const SizedBox(height: 15),
                // Confirm Password field
                InputField(
                  controller: conformPasswordController,
                  isObsecure: !_isConfirmPasswordVisible,
                  prefixIcon: Icons.lock,
                  label: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    icon: Icon(_isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                const SizedBox(height: 160),
                // Sign Up button
                LoginSingupButton(
                  data: 'Sign Up',
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => LoginScreen()));
                      },
                      child: const Text(
                        'Sign in',
                        style:
                            TextStyle(color: Color.fromARGB(255, 23, 83, 133)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
