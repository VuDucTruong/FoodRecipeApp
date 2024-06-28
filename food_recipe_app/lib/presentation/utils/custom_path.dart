import 'dart:math';

import 'package:flutter/cupertino.dart';

class PreferenceItemPath extends CustomClipper<Path> {
  double curve;
  double gap;

  PreferenceItemPath({this.curve = 30, this.gap = 10});

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

    path.moveTo(0, curve);

    path.quadraticBezierTo(0, 0, curve, 0);
    path.lineTo(size.width - curve, 0);
    path.quadraticBezierTo(size.width, 0, size.width, curve);

    path.lineTo(size.width, size.height - curve);
    path.quadraticBezierTo(
        size.width, size.height, size.width - curve, size.height - curve / 2);
    path.lineTo(size.width / 2 + gap, size.height - curve);
    path.quadraticBezierTo(
        size.width / 2,
        size.height - gap * tan(pi / 6) - curve,
        size.width / 2 - gap,
        size.height - curve);
    path.lineTo(curve, size.height - curve / 2);
    path.quadraticBezierTo(0, size.height, 0, size.height - curve);
    //path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
