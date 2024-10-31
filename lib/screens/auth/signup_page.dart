import 'package:financial_app/blocs/auth/auth_bloc.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = RepositoryProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Header
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Color(0xFF446efe),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        textAlign: TextAlign.center,
                        ' Create your account and make every penny count!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 80),
                      // Full Name field
                      InputField(
                          isReadOnly: false,
                          controller: nameController,
                          isObsecure: false,
                          label: 'Full name',
                          suffixIcon: null),
                      const SizedBox(height: 25),
                      // Email field
                      InputField(
                          isReadOnly: false,
                          controller: emailController,
                          isObsecure: false,
                          label: 'Email',
                          suffixIcon: null),
                      const SizedBox(height: 25),
                      // Password field

                      InputField(
                        isReadOnly: false,
                        controller: passwordController,
                        isObsecure: !_isPasswordVisible,
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
                      const SizedBox(height: 25),
                      // Confirm Password field
                      InputField(
                        isReadOnly: false,
                        controller: conformPasswordController,
                        isObsecure: !_isConfirmPasswordVisible,
                        label: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          icon: Icon(_isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(height: 180),
                      // Sign Up button
                    ],
                  ),
                ),
              ),
              SimpleButton(
                data: 'Sign Up',
                onPressed: () {
                  final email = emailController.text;
                  final name = nameController.text;
                  final password = passwordController.text;

                  authBloc.add(
                    AuthSignUpRequest(
                        name: name, email: email, password: password),
                  );
                },
              ),
              const SizedBox(height: 10),
              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const LoginScreen()));
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Color(0xFF456EFE)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
