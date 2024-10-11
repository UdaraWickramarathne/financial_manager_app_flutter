import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:financial_app/components/clickble_textfield.dart';
import 'package:financial_app/components/input_field.dart';
import 'package:financial_app/services/navigators.dart';

import '../../../components/login_singup_button.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String gender = '';
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  bool isEditing = false;

  String originalName = 'Anura kumara';
  String originalEmail = '';
  String originalPhone = '';
  String originalGender = '';
  String originalBirthdate = '';
  String originalBio = '';

  @override
  void initState() {
    super.initState();
    nameController.text = originalName;
    emailController.text = originalEmail;
    phoneController.text = originalPhone;
    genderController.text = originalGender;
    birthdateController.text = originalBirthdate;
    bioController.text = originalBio;
  }

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

  void _saveChanges() {
    setState(() {
      isEditing = false;
    });
  }

  void _resetChanges() {
    setState(() {
      nameController.text = originalName;
      emailController.text = originalEmail;
      phoneController.text = originalPhone;
      genderController.text = originalGender;
      birthdateController.text = originalBirthdate;
      bioController.text = originalBio;
      isEditing = true;
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
                            as ImageProvider,
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
              TextFormField(
                controller: nameController,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                enabled: isEditing,
              ),
              if (!isEditing) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.edit, color: Colors.blue, size: 15),
                          SizedBox(width: 10),
                          Text(
                            'Edit',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              // InputField for name
              InputField(
                controller: nameController,
                isObsecure: false,
                prefixIcon: Icons.supervised_user_circle,
                label: 'Name',
                suffixIcon: null,
                enabled: isEditing,
              ),
              const SizedBox(height: 10),
              InputField(
                controller: emailController,
                isObsecure: false,
                prefixIcon: Icons.email,
                label: 'Email',
                suffixIcon: null,
                enabled: isEditing,
              ),
              const SizedBox(height: 10),
              InputField(
                controller: phoneController,
                isObsecure: false,
                prefixIcon: Icons.phone,
                label: 'Phone Number',
                suffixIcon: null,
                enabled: isEditing,
              ),
              const SizedBox(height: 10),
              ClickbleTextfield(
                prefixIcon: Icons.transgender,
                label: 'Gender',
                controller: genderController,
                onTap: isEditing
                    ? () {
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
                      }
                    : () {},
              ),
              const SizedBox(height: 10),
              ClickbleTextfield(
                prefixIcon: Icons.date_range,
                label: 'Birth Date',
                controller: birthdateController,
                onTap: isEditing
                    ? () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          birthdateController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      }
                    : () {},
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
