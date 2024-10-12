import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80); // Start at bottom left

    // Create a curve from bottom left to bottom right
    final firstControlPoint =
        Offset(size.width / 2, size.height); // Control point for the curve
    final firstEndPoint =
        Offset(size.width, size.height - 80); // End point for the curve
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0); // Complete the rectangle
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
