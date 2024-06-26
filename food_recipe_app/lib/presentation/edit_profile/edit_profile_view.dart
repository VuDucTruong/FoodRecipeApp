import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_alert_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/bio_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/edited_avatar.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/icon_text_field.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/name_text_field.dart';
import 'package:food_recipe_app/presentation/main/home/home_page.dart';
import 'package:food_recipe_app/presentation/main/main_view.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/widgets/avatar_selection.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:get_it/get_it.dart';

import '../utils/background_data_manager.dart';
import '../../domain/entity/background_user.dart';
import '../resources/assets_management.dart';
import '../resources/string_management.dart';

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
  late TextEditingController facebookController;
  late TextEditingController gmailController;
  late EditProfileBloc _editProfileBloc;
  late ProfileInformation profileInformation;
  late BackgroundUser currentUser;
  File? selectedAvatar;
  MutableVariable<MultipartFile?> avatarImage = MutableVariable(null);
  @override
  void initState() {
    super.initState();
    _editProfileBloc = GetIt.instance<EditProfileBloc>();
    currentUser = GetIt.instance<BackgroundDataManager>().getBackgroundUser();
    nameController =
        TextEditingController(text: currentUser.profileInfo.fullName);
    bioController = TextEditingController(text: currentUser.profileInfo.bio);
    facebookController =
        TextEditingController(text: currentUser.profileInfo.facebookLink);
    gmailController =
        TextEditingController(text: currentUser.profileInfo.googleLink);
    profileInformation = currentUser.profileInfo;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
    facebookController.dispose();
    gmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.editProfile.tr(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
        child: BlocListener(
            bloc: _editProfileBloc,
            listener: (context, state) {
              if (state is EditProfileLoading) {
                showDialog(
                  context: context,
                  builder: (context) => const LoadingDialog(),
                );
              }
              if (state is EditProfileSubmitSuccess) {
                Navigator.popUntil(context, (route) => route is! DialogRoute);
                showAnimatedDialog2(
                    context,
                    CongratulationDialog(
                      content: AppStrings.profileUpdated.tr(),
                    )).then((value) {
                  Navigator.pop(context);
                });
              } else if (state is EditProfileDeleteSuccess) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginRoute, ModalRoute.withName(Routes.loginRoute));
              }
              if (state is EditProfileFailed) {
                Failure failure = state.failure;
                handleBlocFailures(context, failure, () {});
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AvatarSelection(
                    imageUrl: profileInformation.avatarUrl,
                    selectedImage: avatarImage,
                  ),
                  Form(
                      key: _formKey,
                      child: NameTextField(
                        controller: nameController,
                      )),
                  BioTextField(
                    controller: bioController,
                  ),
                  IconTextField(
                      iconPath: PicturePath.facebookPath,
                      content: AppStrings.facebook.tr(),
                      controller: facebookController),
                  IconTextField(
                      iconPath: PicturePath.gmailPath,
                      content: AppStrings.gmail.tr(),
                      controller: gmailController),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (avatarImage.value == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(AppStrings.missingAvatar)));
                          }
                          _editProfileBloc.add(EditProfileSubmitEvent(
                              _gatherProfileInformation(), avatarImage.value));
                        }
                      },
                      child: Text(AppStrings.saveProfileInfo.tr()))
                ],
              ),
            ) // done Builder
            ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        gradientBoxShape: BoxShape.circle,
        activeBackgroundColor: Colors.red,
        gradient: ColorManager.linearGradientWhiteOrange,
        children: [
          SpeedDialChild(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AppAlertDialog(
                          content: AppStrings.deleteAccount.tr(),
                          onYes: () {
                            _editProfileBloc.add(EditProfileDeleteEvent());
                          },
                        ));
              },
              child: const Icon(Icons.delete_forever),
              label: AppStrings.deleteAccount.tr()),
          SpeedDialChild(
              onTap: () {
                Navigator.pushNamed(context, Routes.otpRoute, arguments: [
                  currentUser.email,
                  () {
                    Navigator.pushReplacementNamed(
                        context, Routes.changePassRoute);
                  }
                ]);
              },
              child: const Icon(Icons.password),
              label: AppStrings.changePass.tr()),
          SpeedDialChild(
              child: const Icon(Icons.favorite),
              label: AppStrings.editPrefs.tr()),
        ],
      ),
    );
  }

  ProfileInformation _gatherProfileInformation() {
    return ProfileInformation(
        fullName: nameController.text,
        bio: bioController.text,
        facebookLink: facebookController.text,
        googleLink: gmailController.text,
        avatarUrl: profileInformation.avatarUrl,
        categories: profileInformation.categories,
        hungryHeads: profileInformation.hungryHeads,
        isVegan: profileInformation.isVegan);
  }

  bool _preCheckInputs() {
    return nameController.text.isEmpty;
  }
}
