import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final bool isObsecure;
  final IconData? prefixIcon;
  final String? label;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormat;
  final bool isReadOnly;
  final VoidCallback? onTap;

  const InputField({
    super.key,
    required this.isObsecure,
    this.prefixIcon,
    this.label,
    this.suffixIcon,
    required this.controller,
    this.enabled = true,
    this.keyboardType,
    this.inputFormat,
    required this.isReadOnly,
    this.onTap,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: TextField(
        onTap: widget.onTap,
        style: const TextStyle(color: Color.fromARGB(255, 102, 138, 160)),
        controller: widget.controller,
        obscureText: widget.isObsecure,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormat,
        readOnly: widget.isReadOnly,
        decoration: InputDecoration(
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 145, 145, 145)),
          filled: true,
          fillColor: const Color.fromARGB(255, 221, 240, 255),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: const Color.fromARGB(255, 102, 138, 160),
                )
              : null,
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
