import 'package:financial_app/components/simple_button.dart';
import 'package:financial_app/screens/forget_password/email.dart';
import 'package:financial_app/screens/forget_password/otp_verification_screen.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final TextEditingController _emailController = TextEditingController();
  String otp = '';  // Store OTP

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
           ("Email Verification"),
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 100, color: Colors.blue),
            const SizedBox(height: 30),
            const Text("Email Verification", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("We need to send a verification code to your email"),
            const SizedBox(height: 50),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email Address",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const Spacer(),
            SimpleButton(
              data:  "Send Code",
              onPressed: () async {
                String email = _emailController.text;
                if (email.isNotEmpty) {
                  otp = Email().generateOtp();  // Generate OTP
                  await Email().sendOtpEmail(email, otp);  // Send OTP to the entered email

                  // Navigate to OTP verification screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OtpVerificationScreen(otp: otp, email: email),
                    ),
                  );
                } else {
                  // Show error if email is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid email address')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
