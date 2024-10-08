import 'package:flutter/material.dart';

class ServicesIcon extends StatelessWidget {
  final Color? backgroundColor;
  final IconData? icon;
  final Color? foregroundColor;
  final String text;
  const ServicesIcon({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.foregroundColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Icon(
              icon,
              size: 40,
              color: foregroundColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
