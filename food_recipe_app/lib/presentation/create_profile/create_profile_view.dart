import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/common/widgets/dialogs.dart';
import 'package:food_recipe_app/presentation/create_profile/bloc/create_profile_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
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
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () async {
                        _selectedImage = await selectImageFromGalery();
                        setState(() {});
                      },
                      child: Center(
                        child: Stack(
                          children: [
                            /*Container(
                              width: 133,
                              height: 133,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45)),
                              child: _selectedImage == null
                                  ? Image.asset(PicturePath.emptyAvatarPngPath)
                                  : Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                            ),*/
                            CircleAvatar(
                              backgroundColor: ColorManager.whiteOrangeColor,
                              radius: 133 / 2 + 4,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 133 / 2,
                                backgroundImage: (_selectedImage == null
                                        ? const AssetImage(
                                            PicturePath.emptyAvatarPngPath)
                                        : FileImage(_selectedImage!))
                                    as ImageProvider,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: SvgPicture.asset(
                                  PicturePath.editPath,
                                ))
                          ],
                        ),
                      ),
                    ),
                    _getInputForm(),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Center(
                        child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                showAnimatedDialog1(
                                    context, getCongratulationDialog(context));
                              }
                            },
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

  Widget _getInputForm() {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m12),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getTextField(
                content: AppStrings.fullName,
                hint: AppStrings.enterFullName,
                validator: validateFullName),
            _getTextField(
                content: AppStrings.email,
                hint: AppStrings.enterEmail,
                icon: SvgPicture.asset(
                  PicturePath.emailPath,
                  fit: BoxFit.scaleDown,
                ),
                validator: validateEmail),
            _getTextField(
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

  Column _getTextField(
      {required String content,
      required String? Function(String? x) validator,
      Widget? icon,
      required String hint}) {
    return Column(
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
                style:
                    getSemiBoldStyle(color: Colors.red, fontSize: FontSize.s16),
              ),
            ])),
        const SizedBox(
          height: AppSize.s4,
        ),
        SizedBox(
          height: 72,
          child: TextFormField(
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(suffixIcon: icon, hintText: hint)),
        ),
      ],
    );
  }
}
