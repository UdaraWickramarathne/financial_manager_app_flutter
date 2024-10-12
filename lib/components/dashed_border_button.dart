import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DashedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  const DashedButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(15),
      strokeWidth: 1.5, // Adjust stroke width if needed
      padding: EdgeInsets.zero, // Remove padding here
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Match the border radius
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, // Remove padding inside button
            elevation: 0,
            minimumSize:
                const Size(0, 58), // Set minimum height to remove extra space
            backgroundColor: Colors.white, // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color:
                      const Color.fromARGB(255, 0, 0, 0)), // Adjust icon color
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0)), // Text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
