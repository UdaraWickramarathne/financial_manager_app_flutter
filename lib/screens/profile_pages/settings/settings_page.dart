import 'package:financial_app/language/language_provider.dart';
import 'package:financial_app/screens/profile_pages/account_info/change_password.dart';
import 'package:financial_app/themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isOnline = true;
  bool autoLogin = false;
  bool rememberLoginDetails = false;
  bool pinCode = false;
  String pinNumber = '';

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
