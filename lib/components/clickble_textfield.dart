import 'package:flutter/material.dart';

class ClickbleTextfield extends StatefulWidget {
  final IconData? prefixIcon;
  final String label;
  final TextEditingController? controller;
  final VoidCallback onTap;

  const ClickbleTextfield({
    super.key,
    required this.prefixIcon,
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  State<ClickbleTextfield> createState() => _ClickbleTextfieldState();
}

class _ClickbleTextfieldState extends State<ClickbleTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color.fromARGB(255, 102, 138, 160)),
      controller: widget.controller,
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
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      readOnly: true,
      onTap: widget.onTap,
    );
  }
}
