import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/widgets/avatar_selection.dart';

import '../../resources/assets_management.dart';
import '../../resources/font_manager.dart';
import '../../resources/string_management.dart';

class CreateProfileView extends StatefulWidget {
  ThirdPartySignInAccount? thirdPartySignInAccount;
  CreateProfileView({super.key, this.thirdPartySignInAccount});

  @override
  _CreateProfileViewState createState() {
    return _CreateProfileViewState();
  }
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      bioController = TextEditingController();

  MutableVariable<MultipartFile?> avatarImage = MutableVariable(null);
  String? photoUrl;
  @override
  void initState() {
    super.initState();
    if (widget.thirdPartySignInAccount != null) {
      emailController.text = widget.thirdPartySignInAccount!.email;
      nameController.text = widget.thirdPartySignInAccount!.name;
      photoUrl = widget.thirdPartySignInAccount!.photoUrl;
    }
  }

  @override
  void dispose() {
    debugPrint('calling dispose');
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    _formKey.currentState?.dispose();
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
                    imageUrl: photoUrl,
                  ),
                  _getInputForm(),
                  FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (avatarImage.value == null) {
                            showAnimatedDialog2(
                                context,
                                AppErrorDialog(
                                    content: AppStrings.missingAvatar));
                            return;
                          }
                          final registerProfileBasic = gatherProfileSubmit();
                          Navigator.of(context).pushNamed(Routes.foodTypeRoute,
                              arguments: registerProfileBasic);
                        }
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
              )),
        ),
      ),
    );
  }

  UserRegisterProfileBasics gatherProfileSubmit() {
    return UserRegisterProfileBasics(
        loginId: widget.thirdPartySignInAccount?.id,
        email: emailController.text,
        password: passwordController.text,
        fullName: nameController.text,
        bio: bioController.text,
        file: avatarImage.value,
        avatarUrl: photoUrl,
        linkedAccountType:
            widget.thirdPartySignInAccount?.linkedAccountType ?? "");
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
                controller: emailController,
                content: AppStrings.email,
                hint: AppStrings.enterEmail,
                icon: SvgPicture.asset(
                  PicturePath.emailPath,
                  fit: BoxFit.scaleDown,
                ),
                validator: validateEmail),
            CompulsoryTextField(
                isPassword: true,
                controller: passwordController,
                content: AppStrings.password,
                hint: AppStrings.enterPassword,
                icon: SvgPicture.asset(
                  PicturePath.passwordPath,
                  fit: BoxFit.scaleDown,
                ),
                validator: validatePassword),
            CompulsoryTextField(
                controller: nameController,
                content: AppStrings.fullName,
                hint: AppStrings.enterFullName,
                validator: validateEmpty),
            CompulsoryTextField(
              controller: bioController,
              content: AppStrings.bio,
              hint: AppStrings.enterFullName,
              validator: (String? str) => null,
              isCompulsory: false,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class UserRegisterProfileBasics {
  final String? loginId;
  final String fullName;
  final String? email;
  final String? password;
  final String bio;
  final String? avatarUrl;
  final MultipartFile? file;
  final String linkedAccountType;

  UserRegisterProfileBasics(
      {this.loginId,
      required this.fullName,
      this.email,
      this.password,
      required this.bio,
      this.avatarUrl,
      this.file,
      required this.linkedAccountType});
}
