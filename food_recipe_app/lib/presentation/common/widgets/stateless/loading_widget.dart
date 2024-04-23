import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Lottie.asset(LottiePath.loadingPath, height: 100, width: 100),
    );
  }
}
