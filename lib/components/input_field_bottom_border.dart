import 'package:flutter/material.dart';

class InputFieldBottomBorder extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? prefixText;
  final Widget? suffixIcon;
  final Function()? onTap;
  final TextEditingController controller;
  final bool isReadOnly;
  const InputFieldBottomBorder({
    super.key,
    this.keyboardType,
    this.prefixText,
    this.suffixIcon,
    this.onTap,
    required this.controller,
    required this.isReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 25,
      ),
      readOnly: isReadOnly,
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        prefixStyle: const TextStyle(
          fontSize: 25,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFEFEFEF),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF456EFE)),
        ),
      ),
    );
  }
}
