import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/language/language_provider.dart';
import 'package:financial_app/screens/auth/signup_page.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context).translate('login_account')),
      //   actions: [
      //     DropdownButton<Locale>(
      //       value: languageProvider.locale,
      //       onChanged: (Locale? newLocale) {
      //         if (newLocale != null) {
      //           languageProvider.setLocale(newLocale);
      //         }
      //       },
      //       items: const [
      //         DropdownMenuItem(value: Locale('en'), child: Text('English')),
      //         DropdownMenuItem(value: Locale('sl'), child: Text('සිංහල')),
      //       ],
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 80),
              Text(
                AppLocalizations.of(context).translate('login_account'),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF446efe)),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).translate('welcome_back'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 20),
              InputField(
                isReadOnly: false,
                isObsecure: false,
                label: AppLocalizations.of(context).translate('email'),
                suffixIcon: null,
                controller: emailController,
              ),
              const SizedBox(height: 20),
              InputField(
                isReadOnly: false,
                controller: passwordController,
                isObsecure: !_isPasswordVisible,
                label: AppLocalizations.of(context).translate('password'),
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
                      Text(AppLocalizations.of(context)
                          .translate('remember_me')),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context).translate('forgot_password'),
                      style: const TextStyle(color: Color(0xFF446efe)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 160),
              SimpleButton(
                data: AppLocalizations.of(context).translate('login'),
                onPressed: () {},
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context).translate('no_account')),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const SignupScreen()));
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('sign_up'),
                      style: const TextStyle(color: Color(0xFF446efe)),
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
