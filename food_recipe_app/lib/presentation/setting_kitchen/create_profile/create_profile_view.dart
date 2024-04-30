import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/custom_text_form_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/widgets/avatar_selection.dart';

import '../../resources/assets_management.dart';
import '../../resources/font_manager.dart';
import '../../resources/string_management.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  _CreateProfileViewState createState() {
    return _CreateProfileViewState();
  }
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneController = TextEditingController();

  MutableVariable<MultipartFile?> avatarImage = MutableVariable(null);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Text(
                      AppStrings.setUpKitchen,
                      style: getBoldStyle(
                          color: Colors.black, fontSize: FontSize.s20),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      textAlign: TextAlign.left,
                      AppStrings.createProfile,
                      style: getBoldStyle(
                          color: ColorManager.secondaryColor,
                          fontSize: FontSize.s20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                AvatarSelection(
                  selectedImage: avatarImage,
                ),
                _getInputForm(),
                FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          avatarImage.value != null) {
                        Navigator.pushNamed(context, Routes.foodTypeRoute);
                      }
                      /*if (pageIndex >= pages.length - 1) {
                        return;
                      }
                      _pageController.jumpToPage(++pageIndex);*/
                    },
                    child: Text(
                      AppStrings.continueOnly,
                      style: getMediumStyle(
                          color: Colors.white, fontSize: FontSize.s20),
                    )),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getInputForm() {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m12),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CompulsoryTextField(
                controller: nameController,
                content: AppStrings.fullName,
                hint: AppStrings.enterFullName,
                validator: validateEmpty),
            CompulsoryTextField(
                controller: emailController,
                content: AppStrings.email,
                hint: AppStrings.enterEmail,
                icon: SvgPicture.asset(
                  PicturePath.emailPath,
                  fit: BoxFit.scaleDown,
                ),
                validator: validateEmail),
            CompulsoryTextField(
                controller: phoneController,
                content: AppStrings.phoneNum,
                hint: AppStrings.enterPhoneNum,
                icon: SvgPicture.asset(
                  PicturePath.phonePath,
                  fit: BoxFit.scaleDown,
                ),
                validator: validatePhoneNumber),
          ],
        ),
      ),
    );
  }
}
