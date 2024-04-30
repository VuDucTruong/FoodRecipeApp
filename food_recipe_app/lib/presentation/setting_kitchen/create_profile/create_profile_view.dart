import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/bloc/create_profile_bloc.dart';
import 'package:food_recipe_app/presentation/setting_kitchen/create_profile/widgets/avatar_selection.dart';
import 'package:get_it/get_it.dart';

import '../../resources/assets_management.dart';
import '../../resources/font_manager.dart';
import '../../resources/string_management.dart';

class CreateProfileView extends StatefulWidget {
  final ThirdPartySignInAccount? thirdPartySignInAccount;
  const CreateProfileView({super.key,this.thirdPartySignInAccount});

  @override
  _CreateProfileViewState createState() {
    return _CreateProfileViewState();
  }

}

class _CreateProfileViewState extends State<CreateProfileView> {
  final _formKey = GlobalKey<FormState>();
  MutableVariable<File?> _mutableFile = MutableVariable(null);
  CreateProfileBloc? _createProfileBloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _createProfileBloc = GetIt.instance<CreateProfileBloc>();
    if(widget.thirdPartySignInAccount != null){
      nameController.text = widget.thirdPartySignInAccount!.name;
      emailController.text = widget.thirdPartySignInAccount!.email;
    }
  }
  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final String name = nameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;
      final String bio = bioController.text;
      final ThirdPartySignInAccount? thirdPartySignInAccount = widget.thirdPartySignInAccount;
      _createProfileBloc!.add(CreateProfileSubmit(
          name: name,
          email: email,
          password: password,
          bio: bio,
          file: _mutableFile.value,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: BlocConsumer(
              bloc: _createProfileBloc,
              listener: (context,state){
                if(state is CreateProfileSubmitInitial)
                  {
                    handleSubmit();
                  }
                else if(state is CreateProfileSubmitSuccess)
                  {
                    showDialog(context: context,
                        builder: (context)=>const CongratulationDialog());
                    _createProfileBloc!.add(CreateProfileOnNavigate());
                  }
                else if(state is CreateProfileSubmitFailure)
                  {
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      title: const Text("Error"),
                      content: Text(state.errorMessage),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text("OK"))
                      ],
                    ));
                  }
                if(state is CreateProfileLoadingFailure)
                  {
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      title: const Text("Error"),
                      content: Text(state.errorMessage),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text("OK"))
                      ],
                    ));
                  }
              },
              builder: (context,state){
                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.createProfile,
                        style: getBoldStyle(
                            color: ColorManager.secondaryColor, fontSize: FontSize.s20),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).(MaterialPageRoute(
                          //     builder: (context) => const CongratulationDialog()));
                        },
                        child: const SizedBox(
                          width: AppSize.s100,
                          height: AppSize.s100,
                        ),
                      ),
                      AvatarSelection(selectedImage: _mutableFile,),
                      _getInputForm(),
                    ],
                  );
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget _getInputForm() {
    return Container(
      width: 500.0,
      height: 500.0,
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
                validator: (String? str ) => "",
              isCompulsory: false,
              maxLines: 5,
            ),

          ],
        ),
      ),
    );
  }
}
