import 'package:flutter/material.dart';

class BottomSemicircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 12,
        size.width,
        size.height,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}