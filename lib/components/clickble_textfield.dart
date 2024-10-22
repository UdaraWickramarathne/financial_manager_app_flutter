import 'package:flutter/material.dart';

class ClickbleTextfield extends StatefulWidget {
  final IconData? prefixIcon;
  final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const ClickbleTextfield({
    super.key,
    required this.prefixIcon,
    required this.label,
    required this.controller,
    this.onTap,
  });

  @override
  State<ClickbleTextfield> createState() => _ClickbleTextfieldState();
}

class _ClickbleTextfieldState extends State<ClickbleTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: const Color(0xFF0e1633),
        ),
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      readOnly: true,
      onTap: widget.onTap,
    );
  }
}
