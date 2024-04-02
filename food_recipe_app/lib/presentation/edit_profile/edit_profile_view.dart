import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/edited_avatar.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  @override
  void initState() {
    super.initState();
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
      appBar: _buildAppBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const EditedAvatar(),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _getNameEditField(),
                    ],
                  )),
              _getBioEditField(),
              _getIconEditField(
                  iconPath: PicturePath.instagramPath,
                  content: AppStrings.instagram,
                  controller: instagramController),
              _getIconEditField(
                  iconPath: PicturePath.gmailPath,
                  content: AppStrings.gmail,
                  controller: gmailController),
              const SizedBox(
                height: AppSize.s16,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: buildDeleteButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Padding buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: OutlinedButton(
        onPressed: () {
          ////zzzzzz
        },
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
                color: ColorManager.blueColor,
                style: BorderStyle.solid,
                width: 2)),
        child: Text(AppStrings.deleteProfile,
            style: getBoldStyle(color: ColorManager.blueColor)),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.editProfile,
        style: getBoldStyle(
            color: ColorManager.secondaryColor, fontSize: FontSize.s20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) return;
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          PicturePath.backArrowPath,
        ),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return const InputDecoration(
      isDense: true,
      errorStyle: TextStyle(fontSize: FontSize.s12),
      contentPadding: EdgeInsets.zero,
      enabledBorder: UnderlineInputBorder(),
      // focused border
      focusedBorder: UnderlineInputBorder(),

      // error border
      errorBorder: UnderlineInputBorder(),
      // focused error border
      focusedErrorBorder: UnderlineInputBorder(),
    );
  }

  Widget _getBioEditField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.bio,
            style: getBoldStyle(
                color: ColorManager.secondaryColor, fontSize: FontSize.s16),
          ),
          const SizedBox(
            height: AppSize.s4,
          ),
          TextFormField(
              controller: bioController,
              maxLines: null,
              minLines: 1,
              maxLength: 500,
              style: getLightStyle(color: Colors.black, fontSize: FontSize.s16),
              decoration: inputDecoration()),
        ],
      ),
    );
  }

  Widget _getNameEditField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.fullName,
            style: getBoldStyle(
                color: ColorManager.secondaryColor, fontSize: FontSize.s16),
          ),
          const SizedBox(
            height: AppSize.s4,
          ),
          TextFormField(
              controller: nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateEmpty,
              maxLines: null,
              minLines: 1,
              maxLength: 50,
              style: getLightStyle(color: Colors.black, fontSize: FontSize.s16),
              decoration: inputDecoration()),
        ],
      ),
    );
  }

  Widget _getIconEditField(
      {required String iconPath,
      required String content,
      required TextEditingController controller}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 100,
              child: Row(
                children: [
                  SvgPicture.asset(iconPath),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(content,
                      style: getBoldStyle(
                          color: Colors.black, fontSize: FontSize.s14)),
                ],
              )),
          const SizedBox(
            width: AppSize.s8,
          ),
          Expanded(
            child: TextFormField(
                controller: controller,
                style:
                    getLightStyle(color: Colors.black, fontSize: FontSize.s16),
                maxLines: null,
                minLines: 1,
                decoration: inputDecoration()),
          ),
        ],
      ),
    );
  }
}
