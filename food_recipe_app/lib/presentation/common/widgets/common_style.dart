import 'package:flutter/material.dart';

BoxDecoration getBoxDecorationShadow({BorderRadiusGeometry? borderRadius}){
  return BoxDecoration(
    color: Colors.white,
    borderRadius: borderRadius?? BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3), // Shadow color
        spreadRadius: 0, // Spread radius
        blurRadius: 2, // Blur radius
        offset: const Offset(0, 2), // Offset for the shadow (left, top)
      ),
    ],
  );
}