import 'package:financial_app/language/transalation.dart';
import 'package:flutter/material.dart';

import '../../../components/input_field.dart';
import '../../../components/simple_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          AppLocalizations.of(context).translate('change_password'),
          style:const TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            InputField(
              isReadOnly: false,
              controller: oldPasswordController,
              isObsecure: !_oldPasswordVisible,
              prefixIcon: Icons.lock,
              label: AppLocalizations.of(context).translate('old_password'),
              suffixIcon: IconButton(
                icon: Icon(
                  _oldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _oldPasswordVisible = !_oldPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            InputField(
              isReadOnly: false,
              controller: newPasswordController,
              isObsecure: !_newPasswordVisible,
              prefixIcon: Icons.lock,
              label:  AppLocalizations.of(context).translate('new_password'),
              suffixIcon: IconButton(
                icon: Icon(
                  _newPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _newPasswordVisible = !_newPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            InputField(
              isReadOnly: false,
              controller: confirmPasswordController,
              isObsecure: !_confirmPasswordVisible,
              prefixIcon: Icons.lock,
              label: AppLocalizations.of(context).translate('confirm_password'),
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
            ),
            const Spacer(),
            SimpleButton(
              data: 'change_password',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
