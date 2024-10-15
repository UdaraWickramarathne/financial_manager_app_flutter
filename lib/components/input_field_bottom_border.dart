import 'package:flutter/material.dart';

class InputFieldBottomBorder extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? prefixText;
  final Widget? suffixIcon;
  final Function()? onTap;
  final TextEditingController controller;
  final bool isReadOnly;
  final Function(String)? onChange;
  final double? fontSize;
  final TextAlign textAlign;
  const InputFieldBottomBorder({
    super.key,
    this.keyboardType,
    this.prefixText,
    this.suffixIcon,
    this.onTap,
    required this.controller,
    required this.isReadOnly,
    this.onChange,
    this.fontSize,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: fontSize ?? 25,
      ),
      onChanged: onChange,
      readOnly: isReadOnly,
      controller: controller,
      textAlign: textAlign,
      onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
        prefixStyle: TextStyle(
          fontSize: fontSize ?? 25,
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
