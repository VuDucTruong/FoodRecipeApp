import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      appBar: AppBar(
        title: Text(
          AppStrings.editProfile,
          style: getBoldStyle(
              color: ColorManager.secondaryColor, fontSize: FontSize.s20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            PicturePath.backArrowPath,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: AppSize.s100,
                width: AppSize.s100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r15),
                    color: Colors.amber),
              ),
              Text(
                AppStrings.editPicture,
                style: getLightStyle(color: ColorManager.blueColor),
              ),
              _getNameEditField(),
              _getBioEditField(),
              _getCountryEditField(),
              _getIconEditField(Row(
                children: [
                  SvgPicture.asset(PicturePath.instagramPath),
                  const Text(AppStrings.instagram),
                ],
              )),
              _getIconEditField(Row(
                children: [
                  SvgPicture.asset(PicturePath.gmailPath),
                  const Text(AppStrings.gmail),
                ],
              )),
              const SizedBox(
                height: AppSize.s16,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: ColorManager.blueColor,
                        style: BorderStyle.solid,
                        width: 1)),
                child: Text(AppStrings.deleteProfile,
                    style: getBoldStyle(color: ColorManager.blueColor)),
              ),
            ],
          ),
        ),
      ),
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
          Form(
              child: TextFormField(
                  maxLines: null,
                  minLines: 1,
                  maxLength: 500,
                  style: getRegularStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(),
                    // focused border
                    focusedBorder: UnderlineInputBorder(),

                    // error border
                    errorBorder: UnderlineInputBorder(),
                    // focused error border
                    focusedErrorBorder: UnderlineInputBorder(),
                  ))),
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
          Form(
              child: TextFormField(
                  maxLines: null,
                  minLines: 1,
                  maxLength: 50,
                  style: getRegularStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(),
                    // focused border
                    focusedBorder: UnderlineInputBorder(),

                    // error border
                    errorBorder: UnderlineInputBorder(),
                    // focused error border
                    focusedErrorBorder: UnderlineInputBorder(),
                  ))),
        ],
      ),
    );
  }

  Widget _getCountryEditField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.country,
            style: getBoldStyle(
                color: ColorManager.secondaryColor, fontSize: FontSize.s16),
          ),
          const SizedBox(
            height: AppSize.s4,
          ),
          Form(
              child: TextFormField(
                  style: getRegularStyle(color: Colors.black),
                  maxLines: null,
                  minLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(),
                    // focused border
                    focusedBorder: UnderlineInputBorder(),
                    // error border
                    errorBorder: UnderlineInputBorder(),
                    // focused error border
                    focusedErrorBorder: UnderlineInputBorder(),
                  ))),
        ],
      ),
    );
  }

  Widget _getIconEditField(Widget title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title,
          const SizedBox(
            width: AppSize.s8,
          ),
          Expanded(
            child: Form(
                child: TextFormField(
                    style: getRegularStyle(color: Colors.black),
                    maxLines: null,
                    minLines: 1,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(),
                      // focused border
                      focusedBorder: UnderlineInputBorder(),
                      // error border
                      errorBorder: UnderlineInputBorder(),
                      // focused error border
                      focusedErrorBorder: UnderlineInputBorder(),
                    ))),
          ),
        ],
      ),
    );
  }
}
