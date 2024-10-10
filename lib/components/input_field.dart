import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final bool isObsecure;
  final IconData? prefixIcon;
  final String label;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool enabled;

  const InputField({
    super.key,
    required this.isObsecure,
    required this.prefixIcon,
    required this.label,
    required this.suffixIcon,
    required this.controller,
    this.enabled = true,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color.fromARGB(255, 102, 138, 160)),
      controller: widget.controller,
      obscureText: widget.isObsecure,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
        filled: true,
        fillColor: const Color.fromARGB(255, 221, 240, 255),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: const Color.fromARGB(255, 102, 138, 160),
        ),
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
