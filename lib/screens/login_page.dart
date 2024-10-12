import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/login_singup_button.dart';
import 'package:financial_app/screens/signup_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/bitcoin-clip.png",
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  InputField(
                    isReadOnly: false,
                    isObsecure: false,
                    prefixIcon: Icons.person,
                    label: 'Full name',
                    suffixIcon: null,
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    isReadOnly: false,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  SimpleButton(
                    data: 'Login',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const SignupScreen()));
                        },
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
