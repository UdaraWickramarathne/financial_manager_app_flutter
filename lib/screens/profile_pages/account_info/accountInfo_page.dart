import 'package:financial_app/components/clickble_textfield.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/components/login_singup_button.dart';
import 'package:financial_app/services/navigators.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String gender = '';
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _selectGender(String value) {
    setState(() {
      gender = value;
      genderController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/profile.jpg')
                            as ImageProvider, // Placeholder image
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Jack Black',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              InputField(
                  controller: emailController,
                  isObsecure: false,
                  prefixIcon: Icons.email,
                  label: 'Email',
                  suffixIcon: null),
              const SizedBox(height: 10),
              InputField(
                  controller: emailController,
                  isObsecure: false,
                  prefixIcon: Icons.phone,
                  label: 'Phone Number',
                  suffixIcon: null),
              const SizedBox(height: 10),
              ClickbleTextfield(
                prefixIcon: Icons.male,
                label: 'Gender',
                controller: genderController,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Select Gender'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              ListTile(
                                title: const Text('Male'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _selectGender('Male');
                                },
                              ),
                              ListTile(
                                title: const Text('Female'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _selectGender('Female');
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              ClickbleTextfield(
                prefixIcon: Icons.male,
                label: 'Birth Date',
                controller: genderController,
                onTap: () {
                  /*
                  NEED

                  TO

                  ADD

                  CALENDER

                  */

                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: const Text('Select Gender'),
                  //       content: SingleChildScrollView(
                  //         child: ListBody(
                  //           children: <Widget>[
                  //             ListTile(
                  //               title: const Text('Male'),
                  //               onTap: () {
                  //                 Navigator.of(context).pop();
                  //                 _selectGender('Male');
                  //               },
                  //             ),
                  //             ListTile(
                  //               title: const Text('Female'),
                  //               onTap: () {
                  //                 Navigator.of(context).pop();
                  //                 _selectGender('Female');
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ),
              const SizedBox(height: 10),
              InputField(
                  controller: emailController,
                  isObsecure: false,
                  prefixIcon: Icons.library_books,
                  label: 'Bio',
                  suffixIcon: null),
              const SizedBox(height: 80),
              SimpleButton(
                data: 'Save',
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  profileNavigatorKey.currentState!
                      .pushNamed('/reset_password');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_reset, color: Colors.blue),
                    SizedBox(width: 15),
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
