
import 'package:financial_app/screens/convertor/money_convertor.dart';
import 'package:financial_app/screens/goals/add_goal_page.dart';
import 'package:financial_app/screens/goals/goal_page.dart';
import 'package:financial_app/screens/home/home_page.dart';
import 'package:financial_app/screens/payment_pages/bill_payment_page.dart';
import 'package:financial_app/screens/payment_pages/types_of_bill/electricity_bill.dart';
import 'package:financial_app/screens/profile_pages/account_info/accountInfo_page.dart';
import 'package:financial_app/screens/profile_pages/account_info/reset_password.dart';
import 'package:financial_app/screens/profile_pages/settings/settings_page.dart';
import 'package:financial_app/screens/reminder/add_reminder.dart';

import 'package:financial_app/themes/themedata.dart';
import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    Provider.of<ThemeProvider>(context, listen: false)
        .updateThemeBasedOnSystem(brightness);
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      darkTheme: darkMode,
      themeMode: themeProvider.themeMode,
      home: const AddReminder(),
    );
  }
}
