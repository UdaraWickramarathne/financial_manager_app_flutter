import 'package:financial_app/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'rating/rating_dialog.dart';

import '../../components/ProfileOption.dart';
import 'account_info/accountInfo_screen.dart';
import 'privacy_policy/privacy_policy_screen.dart';
import 'settings/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ValueNotifier<double> _userRating = ValueNotifier<double>(0);

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to show star rating dialog
 /* void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rate Our App"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _userRating
                          ? Icons.star // Filled star
                          : Icons.star_border, // Empty star
                      color: Colors.amber,
                      size: 40, // Adjust star size
                    ),
                    onPressed: () {
                      setState(() {
                        _userRating = index + 1; // Update user rating
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              Text("Your rating: $_userRating"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                // Handle the rating submission (e.g., save to a database)
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await RatingDialog.showRatingDialog(context, _userRating);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : null,
                        child: _image == null
                            ? const Icon(
                          Icons.person,
                          size: 80,
                        )
                            : null,
                      ),
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlueAccent,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: _pickImage,
                        iconSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Anura Kumara',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'anurakumara@gmail.com',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                ProfileOption(
                  icon: Icons.account_circle_outlined,
                  text: 'Account Info',
                  iconColor: Colors.deepPurpleAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountInfoScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                ProfileOption(
                  icon: Icons.privacy_tip_outlined,
                  text: 'Privacy Policy',
                  iconColor: Colors.blueGrey,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                ProfileOption(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                ProfileOption(
                  icon: Icons.star_rate_outlined,
                  text: 'Rate App',
                  iconColor: Color(0xFFFFD700),
                  onTap: () {
                    RatingDialog.showRatingDialog(context, _userRating);
                  },
                ),
                const SizedBox(height: 5),
                ProfileOption(
                  icon: Icons.logout,
                  text: 'Logout',
                  iconColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Logout"),
                          content: const Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Logout"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
