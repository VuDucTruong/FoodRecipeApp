import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

import '../../resources/route_management.dart';
import '../../resources/string_management.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
           CircleAvatar(
            backgroundImage: AssetImage(PicturePath.logoPath),
            radius: AppRadius.r45,
          ),
          Text(AppStrings.continueWith),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getLoginType(
                  path: PicturePath.fbPath, content: AppStrings.facebook),
              SizedBox(
                width: AppSize.s8,
              ),
              _getLoginType(
                  path: PicturePath.ggPath, content: AppStrings.google),
            ],
          ),
          Text(AppStrings.or),
        ],
      ),
    );
  }

  Widget _getLoginType({required String path, required String content}) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(path),
            radius: AppRadius.r45,
          ),
          const SizedBox(
            width: AppSize.s4,
          ),
          Text(content)
        ],
      ),
    );
  }
}
