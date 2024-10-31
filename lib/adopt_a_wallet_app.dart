import 'package:feedback/feedback.dart';
import 'package:financial_app/language/language_provider.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:financial_app/navigators/navigation_keys.dart';
import 'package:financial_app/screens/home/home_page.dart';

import 'package:financial_app/services/feedback_repository.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:shake/shake.dart';
import 'package:financial_app/themes/themedata.dart';
import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

class AdoptAWalletApp extends StatefulWidget {
  const AdoptAWalletApp({super.key});

  @override
  State<AdoptAWalletApp> createState() => _AdoptAWalletAppState();
}

class _AdoptAWalletAppState extends State<AdoptAWalletApp>
    with WidgetsBindingObserver {
  late ShakeDetector shakeDetector;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: () {
        BetterFeedback.of(context).show((UserFeedback feedback) async {
          final screenshotFilePath =
              await writeImageToStorage(feedback.screenshot);
          final Email email = Email(
            body: feedback.text,
            subject: 'App Feedback',
            recipients: ['adoptawallet.devnet@gmail.com'],
            attachmentPaths: [screenshotFilePath],
            isHTML: false,
          );
          await FlutterEmailSender.send(email);
        });
      },
      minimumShakeCount: 3,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
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
    shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    var app = MaterialApp(
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeProvider.themeMode,
      locale: languageProvider.locale,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('sl', ''), // Sinhala
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const HomePage(),
    );
    return app;
  }
}
