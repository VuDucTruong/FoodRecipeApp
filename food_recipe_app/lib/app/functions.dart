import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../presentation/resources/string_management.dart';

Future<T?> showAnimatedDialog1<T extends Object?>(
    BuildContext context, Widget dialog) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) {
      return dialog;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(
                CurvedAnimation(parent: animation, curve: Curves.bounceOut)),
        child: child,
      );
    },
  );
}

Future<T?> showAnimatedDialog2<T extends Object?>(
    BuildContext context, Widget dialog) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) {
      return dialog;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.bounceOut)),
        child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: child),
      );
    },
  );
}

final _emailRegex = RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$');
final _phoneRegex = RegExp(r'^[0-9]{10,11}$');
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.emailRequiredError;
  }
  if (!_emailRegex.hasMatch(value)) {
    return AppStrings.emailFormatError;
  }
  return null;
}

String? validateFullName(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.nameRequiredError;
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.phoneRequiredError;
  }
  if (!_phoneRegex.hasMatch(value)) {
    return AppStrings.phoneValidationError;
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.passRequiredError;
  }
  if (value.length < 8) {
    return AppStrings.passValidationError;
  }
  return null;
}

Future<File?> selectImageFromGalery() async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  return File(image.path);
}
