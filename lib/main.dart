import 'package:financial_app/adopt_a_wallet_app.dart';
import 'package:financial_app/language/language_provider.dart';
import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const AdoptAWalletApp(),
    ),
  );
}
