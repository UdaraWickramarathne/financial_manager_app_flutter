import 'package:financial_app/components/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:financial_app/components/clickble_textfield.dart';
import 'package:financial_app/components/input_field.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  String originalName = 'Anura kumara';
  String originalEmail = 'anurakumara@gmail.com';
  String originalPhone = '07111111111';
  String originalGender = '';
  String originalBirthdate = '';

  @override
  void initState() {
    super.initState();
    nameController.text = originalName;
    emailController.text = originalEmail;
    phoneController.text = originalPhone;
    genderController.text = originalGender;
    birthdateController.text = originalBirthdate;
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
      genderController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                border:
                                    Border.all(color: Colors.white, width: 2),
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
                      'Anura Kumara',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    InputField(
                      isReadOnly: false,
                      controller: nameController,
                      isObsecure: false,
                      prefixIcon: Icons.supervised_user_circle,
                      label: 'Name',
                      suffixIcon: null,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      isReadOnly: false,
                      controller: emailController,
                      isObsecure: false,
                      prefixIcon: Icons.email,
                      label: 'Email',
                      suffixIcon: null,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      isReadOnly: false,
                      controller: phoneController,
                      isObsecure: false,
                      prefixIcon: Icons.phone,
                      label: 'Phone Number',
                      suffixIcon: null,
                    ),
                    const SizedBox(height: 20),
                    ClickbleTextfield(
                      prefixIcon: Icons.transgender,
                      label: 'Select Gender',
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
                    const SizedBox(height: 20),
                    ClickbleTextfield(
                      prefixIcon: Icons.date_range,
                      label: 'Select Birth Date',
                      controller: birthdateController,
                      onTap: () async {
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
                      },
                    ),
                  ],
                ),
              ),
            ),
            SimpleButton(
              data: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
