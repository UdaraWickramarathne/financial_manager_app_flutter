import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final bool isObsecure;
  final IconData? prefixIcon;
  final String? label;
  final String? prefixText;
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
    this.prefixText,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      style: const TextStyle(
        fontSize: 16,
      ),
      controller: widget.controller,
      obscureText: widget.isObsecure,
      textAlignVertical: TextAlignVertical.center,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormat,
      readOnly: widget.isReadOnly,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF456EFE), width: 1.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        prefixText: widget.prefixText,
        prefixStyle: const TextStyle(
          color: Color(0xFF0e1633),
          fontSize: 16,
        ),
        labelStyle: const TextStyle(color: Color(0xFF626262)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceDim,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: const Color(0xFF1b2c66),
              )
            : null,
        labelText: widget.label,
        suffixIcon: widget.suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
