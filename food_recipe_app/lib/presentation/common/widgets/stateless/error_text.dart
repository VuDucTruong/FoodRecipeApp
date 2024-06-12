import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:lottie/lottie.dart';

class ErrorText extends StatelessWidget {
  ErrorText({super.key, required this.failure});
  Failure failure;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      child: Center(
          child: Column(
        children: [
          Lottie.asset(LottiePath.exclamationPath, width: 100, height: 100),
          Text(
            '${failure.code} - ${failure.message}',
            style: getSemiBoldStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      )),
    );
  }
}
