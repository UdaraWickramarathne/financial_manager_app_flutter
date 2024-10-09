import 'package:flutter/material.dart';
import '../../themes/theme.dart';
import '../profile_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isOnline = true;
  bool isDarkMode = false;
  bool autoLogin = false;
  bool rememberLoginDetails = false;
  bool pinCode = false;
  String pinNumber = '';

  void _onPinChange(String value) {
    if (value.length <= 4) {
      setState(() {
        pinNumber = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.blue,
              ),
              title: const Text('Dark Mode'),
              trailing: IconButton(
                icon: Icon(isDarkMode ? Icons.toggle_on : Icons.toggle_off),
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                pinCode ? Icons.lock : Icons.lock_open,
                color: Colors.blue,
              ),
              title: const Text('PIN Code'),
              trailing: IconButton(
                icon: Icon(pinCode ? Icons.toggle_on : Icons.toggle_off),
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    pinCode = !pinCode;
                  });
                },
              ),
            ),
            if (pinCode)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter PIN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'PIN (4 digits)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      onChanged: _onPinChange,
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Save PIN functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Save PIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help / Support'),
              onTap: () {
                // Handle Help / Support tap
              },
            ),
            ListTile(
              title: const Text('Language'),
              trailing: DropdownButton<String>(
                value: 'English',
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
                ],
                onChanged: (String? value) {
                  // Handle language change
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: Text('v1.10.0')),
            ),
          ],
        ),
      ),
    );
  }
}
