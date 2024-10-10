import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String data;
  final Function()? onPressed;
  final Color color;
  const SimpleButton({
    super.key,
    required this.data,
    required this.onPressed,
    this.color = const Color.fromARGB(255, 102, 138, 160),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            data,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
