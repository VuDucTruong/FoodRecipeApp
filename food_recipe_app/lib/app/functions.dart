import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_otp/email_otp.dart';

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

String? validateEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.emptyError;
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
  if (value.length < 6) {
    return AppStrings.passValidationError;
  }
  return null;
}

String? validateMatch(String? value1, String? value2) {
  if (value1 != value2) {
    return AppStrings.notMatchPass;
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

Future<void> sendOTP(EmailOTP myAuth, String email) async {
  var template = 'Thank you for choosing {{app_name}}. Your OTP is {{otp}}.';
  myAuth.setTemplate(render: template);
  myAuth.setTheme(theme: "v2");
  myAuth.setConfig(
      appEmail: "cookit998@gmail.com",
      appName: "Cook It",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly);
  await myAuth.sendOTP();
}

bool isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

void handleBlocFailures(
    BuildContext context, Failure failure, Function reload) {
  if (failure.code == ResponseCode.NO_INTERNET_CONNECTION) {
    showDialog(
        context: context,
        builder: (context) => NoConnectionDialog(reload: reload));
  } else if (failure.code == ResponseCode.DEFAULT) {
    showDialog(
        context: context,
        builder: (context) => AppErrorDialog(content: failure.message));
  } else if (failure.code == ResponseCode.BAD_REQUEST) {
    showDialog(
        context: context,
        builder: (context) => AppErrorDialog(content: AppStrings.invalidInput));
  } else if (failure.code == ResponseCode.UNAUTHORISED) {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.unauthorizedError));
  } else if (failure.code == ResponseCode.INTERNAL_SERVER_ERROR) {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.internalServerError));
  } else if (failure.code == ResponseCode.CONNECT_TIMEOUT) {
    showDialog(
        context: context,
        builder: (context) => AppErrorDialog(content: AppStrings.timeoutError));
  } else {
    showDialog(
        context: context,
        builder: (context) =>
            AppErrorDialog(content: AppStrings.somethingWentWrong));
  }
}
