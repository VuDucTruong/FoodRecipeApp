import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

import '../resources/assets_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  _CreateProfileViewState createState() {
    return _CreateProfileViewState();
  }
}

class _CreateProfileViewState extends State<CreateProfileView> {
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
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(AppMargin.m8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  AppStrings.setUpKitchen,
                  style:
                      getBoldStyle(color: Colors.black, fontSize: FontSize.s20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Text(
                      AppStrings.createProfile,
                      style: getBoldStyle(
                          color: ColorManager.secondaryColor,
                          fontSize: FontSize.s20),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            PicturePath.emptyAvatarPath,
                            width: 133,
                            height: 133,
                          ),
                          Positioned(
                              bottom: 0,
                              right: 10,
                              child: SvgPicture.asset(
                                PicturePath.editPath,
                              ))
                        ],
                      ),
                    ),
                    _getTextInput(
                        content: AppStrings.username,
                        hint: AppStrings.enterUsername),
                    _getTextInput(
                        content: AppStrings.fullName,
                        hint: AppStrings.enterFullName),
                    _getTextInput(
                        content: AppStrings.email, hint: AppStrings.enterEmail),
                    _getTextInput(
                        content: AppStrings.phoneNum,
                        hint: AppStrings.enterPhoneNum),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Center(
                        child: FilledButton(
                            onPressed: () {},
                            child: Text(
                              AppStrings.continueOnly,
                              style: getMediumStyle(
                                  color: Colors.white, fontSize: FontSize.s20),
                            ))),
                    const SizedBox(
                      height: AppSize.s20,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTextInput(
      {required String content, required String hint, Widget? icon}) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  style: getSemiBoldStyle(
                      color: Colors.black, fontSize: FontSize.s16),
                  children: [
                TextSpan(text: content),
                TextSpan(
                  text: " *",
                  style: getSemiBoldStyle(
                      color: Colors.red, fontSize: FontSize.s16),
                ),
              ])),
          const SizedBox(
            height: AppSize.s4,
          ),
          Material(
              elevation: 2,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(12),
              child: Form(
                child: TextFormField(
                    decoration:
                        InputDecoration(suffixIcon: icon, hintText: hint)),
              )),
        ],
      ),
    );
  }
}
