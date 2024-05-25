
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/network/failure.dart';
import 'package:food_recipe_app/domain/entity/user_entity.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_alert_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/bio_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/edited_avatar.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/icon_text_field.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/name_text_field.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/widgets/avatar_selection.dart';
import 'package:get_it/get_it.dart';

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
  late ProfileInformation profileInformation;
  late EditProfileBloc _editProfileBloc;
  MutableVariable<MultipartFile?> avatarImage = MutableVariable(null);
  @override
  void initState() {
    super.initState();
    _editProfileBloc = GetIt.instance<EditProfileBloc>();
    nameController = TextEditingController();
    bioController = TextEditingController();
    facebookController = TextEditingController();
    gmailController = TextEditingController();
    profileInformation = ProfileInformation.defaultValues();
    _editProfileBloc.add(EditProfileInitialLoadEvent());
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
      appBar: const CustomAppBar(
        title: AppStrings.editProfile,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
        child: BlocConsumer(
          bloc: _editProfileBloc,
          listener: (context, state) {
            Navigator.popUntil(context, (route) => route is! DialogRoute);
            debugPrint("ran here aslkdjfklajsdklfjalksdjf");
            if (state is EditProfileSuccess) {
              if(state is EditProfileInitialLoadSuccess){
                profileInformation = state.profileInformation;
                debugPrint("ProfileInformation: ${state.profileInformation.toJson()}");
                setState(() {
                  nameController.text = state.profileInformation.fullName;
                  bioController.text = state.profileInformation.bio;
                  facebookController.text = state.profileInformation.facebookLink??"";
                  gmailController.text = state.profileInformation.googleLink??"";
                });
              }
                else if(state is EditProfileSubmitSuccess){
                showDialog(context: context,
                    builder: (context)=> CongratulationDialog(content: "Profile updated",));
                profileInformation = state.profileInformation;
                setState(() {
                    nameController.text = state.profileInformation.fullName;
                    bioController.text = state.profileInformation.bio;
                    facebookController.text = state.profileInformation.facebookLink??"";
                    gmailController.text = state.profileInformation.googleLink??"";
                  });
                }
                else if(state is EditProfileDeleteSuccess){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.mainRoute,
                  ModalRoute.withName(Routes.loginRoute));
                }
            }
            else if(state is EditProfileFailed){
              Failure failure = state.failure;
              handleBlocFailures(context, failure, (){});
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  AvatarSelection(
                    imageUrl: profileInformation.avatarUrl,
                    selectedImage: avatarImage,
                  ),
              if(state is EditProfileLoading)
                const CircularProgressIndicator(),
                  Form(
                      key: _formKey,
                      child: NameTextField(
                        controller: nameController,
                      )),
                  BioTextField(
                      controller: bioController,),
                  IconTextField(
                      iconPath: PicturePath.instagramPath,
                      content: AppStrings.instagram,
                      controller: facebookController),
                  IconTextField(
                      iconPath: PicturePath.gmailPath,
                      content: AppStrings.gmail,
                      controller: gmailController),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilledButton(
                          onPressed: ()  {
                            debugPrint("pressed");
                            if (_formKey.currentState!.validate()) {
                              if(avatarImage.value==null)
                              {debugPrint("selectedAvatar is null");}
                              _editProfileBloc.add(
                                  EditProfileSubmitEvent(_gatherProfileInformation(), avatarImage.value ));
                            }
                          },
                          child: const Text(AppStrings.saveProfileInfo)),
                      FilledButton(
                          onPressed: ()  {
                            showDialog(context: context, builder: (context)
                            => AppAlertDialog(content: AppStrings.deleteAccount,
                              onYes: () {
                                _editProfileBloc.add(EditProfileDeleteEvent());
                              },
                            ));
                          },
                          child: const Text(AppStrings.deleteAccount)),
                    ],
                  )

                ],

              ),
            );
            },// done Builder
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

  ProfileInformation _gatherProfileInformation() {
    return ProfileInformation(
      fullName: nameController.text,
      bio: bioController.text,
      facebookLink: facebookController.text,
      googleLink: gmailController.text,
      avatarUrl: profileInformation.avatarUrl,
      categories: profileInformation.categories,
      hungryHeads: profileInformation.hungryHeads,
      isVegan: profileInformation.isVegan
    );
  }
  bool _preCheckInputs(){
    return nameController.text.isEmpty;
  }

}
