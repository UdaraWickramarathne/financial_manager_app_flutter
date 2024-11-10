import 'package:financial_app/language/language_provider.dart';
import 'package:financial_app/screens/profile-pages/account_info/change_password.dart';
import 'package:financial_app/services/sms_service.dart';
import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isOnline = true;
  bool autoLogin = false;
  bool rememberLoginDetails = false;
  bool pinCode = false;
  String pinNumber = '';

  final bool _isListening = false;

  @override
  void initState() {
    super.initState();
    // _loadListeningPreference();
  }

  // // Load the saved listening preference from SharedPreferences
  // Future<void> _loadListeningPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isListening = prefs.getBool('isListening') ?? false;
  //   });

  //   // Start listening automatically if the saved preference is true
  //   if (_isListening) {
  //     SmsService.startListening();
  //   }
  // }

  // // Toggle listening state and save it to SharedPreferences
  // Future<void> _toggleListening(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isListening = value;
  //   });

  //   await prefs.setBool('isListening', _isListening);

  //   if (_isListening) {
  //     SmsService.startListening();
  //   } else {
  //     // Optionally, add functionality to stop listening if needed
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'ACCOUNT',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.key,
                size: 26,
              ),
              title: const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePassword(),
                    ));
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.timer,
                size: 26,
              ),
              title: const Text(
                'Realitime Tracking',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: _isListening,
                  onChanged: (value) {
                    // _toggleListening(value);
                  },
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePassword(),
                    ));
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Colors.grey),
          ),
          const Text(
            'APPEARENCE',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 26,
              ),
              title: const Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(!isDarkMode);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.language,
                size: 26,
              ),
              title: const Text(
                'Language',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  elevation: 6,
                  value: languageProvider.locale,
                  items: const [
                    DropdownMenuItem(
                        value: Locale('en'), child: Text('English')),
                    DropdownMenuItem(value: Locale('sl'), child: Text('සිංහල')),
                  ],
                  onChanged: (Locale? value) {
                    if (value != null) {
                      languageProvider.setLocale(value);
                    }
                  },
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Colors.grey),
          ),
          const Text(
            'SECURITY',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(
                pinCode ? Icons.lock : Icons.lock_open,
                size: 26,
              ),
              title: const Text(
                'PIN Code',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: pinCode,
                  onChanged: (value) {
                    setState(() {
                      pinCode = value;
                    });
                  },
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Colors.grey),
          ),
          const Text(
            'APP INFORMATION',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.help_outline,
                size: 26,
              ),
              title: const Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                // Handle Help / Support tap
              },
            ),
          ),
          const SizedBox(height: 80),
          const Center(
              child: Text(
            'v1.0.0',
            style: TextStyle(fontSize: 16),
          )),
        ],
      ),
    );
  }
}
