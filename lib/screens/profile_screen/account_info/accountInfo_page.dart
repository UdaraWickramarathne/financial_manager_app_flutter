import 'package:flutter/material.dart';


class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
      ),
      body: const Center(
        child: Text('Account Info Screen'),
      ),
    );
  }
}
