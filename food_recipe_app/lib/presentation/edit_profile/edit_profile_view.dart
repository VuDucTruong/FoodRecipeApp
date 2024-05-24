import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/bio_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/edited_avatar.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/icon_text_field.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/name_text_field.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entity/background_user.dart';
import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
import '../resources/route_management.dart';
import '../resources/string_management.dart';
import '../resources/style_management.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() {
    return _EditProfileViewState();
  }
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController instagramController;
  late TextEditingController gmailController;
  late BackgroundUser currentUser;
  File? selectedAvatar;
  @override
  void initState() {
    super.initState();
    currentUser = GetIt.instance<BackgroundDataManager>().getBackgroundUser();
    nameController =
        TextEditingController(text: currentUser.profileInfo.fullName);
    bioController = TextEditingController(text: currentUser.profileInfo.bio);
    instagramController =
        TextEditingController(text: currentUser.profileInfo.fullName);
    gmailController =
        TextEditingController(text: currentUser.profileInfo.fullName);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
    instagramController.dispose();
    gmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editProfile,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EditedAvatar(
                avatarUrl: currentUser.profileInfo.avatarUrl,
                selectedImage: selectedAvatar,
              ),
              Form(
                  key: _formKey,
                  child: NameTextField(
                    controller: nameController,
                    initialValue: currentUser.profileInfo.fullName,
                  )),
              BioTextField(
                  controller: bioController,
                  initialValue: currentUser.profileInfo.bio),
              IconTextField(
                  iconPath: PicturePath.instagramPath,
                  content: AppStrings.instagram,
                  controller: instagramController),
              IconTextField(
                  iconPath: PicturePath.gmailPath,
                  content: AppStrings.gmail,
                  controller: gmailController),
              const SizedBox(
                height: AppSize.s16,
              ),
              FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      /////////zzzz
                    }
                  },
                  child: const Text(AppStrings.saveProfileInfo))
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        gradientBoxShape: BoxShape.circle,
        activeBackgroundColor: Colors.red,
        gradient: ColorManager.linearGradientWhiteOrange,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.delete_forever),
              label: AppStrings.deleteAccount),
          SpeedDialChild(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.changePassRoute);
                  },
                  child: const Icon(Icons.password)),
              label: AppStrings.changePass),
          SpeedDialChild(
              child: const Icon(Icons.favorite), label: AppStrings.editPrefs),
        ],
      ),
    );
  }
}
