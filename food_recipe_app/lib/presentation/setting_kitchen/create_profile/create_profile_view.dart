import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/bloc/create_profile_bloc.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/widgets/avatar_selection.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:get_it/get_it.dart';

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
  late CreateProfileBloc _createProfileBloc;

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
    _createProfileBloc = GetIt.instance<CreateProfileBloc>();
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
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.signUp.tr(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer(
              bloc: _createProfileBloc,
              listener: (context, state) {
                Navigator.popUntil(context, (route) => route is! DialogRoute);
                if (state is CreateProfileLoading) {
                  showDialog(
                      context: context,
                      builder: (context) => const LoadingDialog());
                } else if (state is CreateProfileSubmitSuccess) {
                  final registerProfileBasic = gatherProfileSubmit();
                  Navigator.pushNamed(context, Routes.otpRoute, arguments: [
                    registerProfileBasic.email,
                    () {
                      Navigator.of(context).pushReplacementNamed(
                          Routes.foodTypeRoute,
                          arguments: registerProfileBasic);
                    }
                  ]);
                } else if (state is CreateProfileSubmitFailed) {
                  final failure = state.failure;
                  handleBlocFailures(
                      context, failure, () => Navigator.of(context).pop());
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    AvatarSelection(
                      imageUrl: photoUrl,
                      selectedImage: avatarImage,
                    ),
                    _getInputForm(),
                    FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _createProfileBloc.add(
                                CreateProfileOnContinuePressed(
                                    email: emailController.text));
                          }
                        },
                        child: Text(
                          AppStrings.continueOnly.tr(),
                          style: getMediumStyle(
                              color: Colors.white, fontSize: FontSize.s20),
                        )),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                );
              },
            ),
          ),
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
                controller: passwordController,
                content: AppStrings.password,
                hint: AppStrings.enterPassword,
                isPassword: true,
                validator: validatePassword),
            CompulsoryTextField(
                controller: nameController,
                content: AppStrings.fullName,
                hint: AppStrings.enterFullName,
                validator: validateEmpty),
            CompulsoryTextField(
              controller: bioController,
              content: AppStrings.bio,
              hint: AppStrings.enterBio,
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
