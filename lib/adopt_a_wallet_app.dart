import 'package:feedback/feedback.dart';
import 'package:financial_app/blocs/auth/auth_bloc.dart';
import 'package:financial_app/blocs/budget/budget_bloc.dart';
import 'package:financial_app/blocs/goal/goal_bloc.dart';
import 'package:financial_app/blocs/reminder/reminder_bloc.dart';
import 'package:financial_app/blocs/transaction/transaction_bloc.dart';
import 'package:financial_app/language/language_provider.dart';
import 'package:financial_app/language/transalation.dart';
import 'package:financial_app/navigators/navigation_keys.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'package:financial_app/repositories/budget/budget_repository.dart';
import 'package:financial_app/repositories/goal/goal_repository.dart';
import 'package:financial_app/repositories/reminder/reminder_repository.dart';
import 'package:financial_app/repositories/transaction/transaction_repository.dart';
import 'package:financial_app/screens/auth/login_page.dart';
import 'package:financial_app/services/feedback_repository.dart';
import 'package:financial_app/services/sms_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      minimumShakeCount: 2,
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
    var authRepository = AuthRepository();
    var transactionRepository = TransactionRepository();
    var goalRepository = GoalRepository();
    var reminderRepository = ReminderRepository();
    var budgetRepository = BudgetRepository();
    var transactionBloc =
        TransactionBloc(transactionRepository, authRepository);

    var smsService = SmsService(
      transactionBloc: transactionBloc,
      authRepository: authRepository,
    );

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
      home: const LoginScreen(),
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => authRepository,
        ),
        RepositoryProvider(
          create: (context) => transactionRepository,
        ),
        RepositoryProvider(
          create: (context) => goalRepository,
        ),
        RepositoryProvider(
          create: (context) => reminderRepository,
        ),
        RepositoryProvider(
          create: (context) => budgetRepository,
        ),
        RepositoryProvider(
          create: (context) => AuthBloc(authRepository),
        ),
        RepositoryProvider(
          create: (context) => transactionBloc,
        ),
        RepositoryProvider(
          create: (context) => GoalBloc(goalRepository),
        ),
        RepositoryProvider(
          create: (context) => ReminderBloc(reminderRepository),
        ),
        RepositoryProvider(
          create: (context) => BudgetBloc(budgetRepository),
        ),
        Provider(create: (context) => smsService),
      ],
      child: app,
    );
  }
}
