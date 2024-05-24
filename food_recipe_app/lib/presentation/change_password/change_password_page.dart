import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/custom_text_form_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/change_password_success_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:get_it/get_it.dart';

import '../blocs/user_profile/user_profile_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //final UserProfileBloc _userProfileBloc = GetIt.instance<UserProfileBloc>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.changePass),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(PicturePath.changePassPath,
                  width: pixelRatio * 100, height: pixelRatio * 90),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      CompulsoryTextField(
                        content: AppStrings.oldPassword,
                        validator: validatePassword,
                        hint: AppStrings.hintOldPassword,
                        controller: oldPasswordController,
                        isPassword: true,
                        isCompulsory: true,
                      ),
                      CompulsoryTextField(
                        content: AppStrings.newPassword,
                        validator: validatePassword,
                        hint: AppStrings.hintNewPassword,
                        controller: newPasswordController,
                        isPassword: true,
                        isCompulsory: true,
                      ),
                    ],
                  ),
                ),
              ),
              /*BlocListener<UserProfileBloc, UserProfileState>(
                //bloc: _userProfileBloc,
                listener: (context, state) {
                  if (state is UserPasswordLoadingState) {
                    showAnimatedDialog1(context, const LoadingDialog());
                  }
                  if (state is UserPasswordChangedState) {
                    Navigator.popUntil(context, (route) => route is! DialogRoute);
                    showAnimatedDialog1(context, ChangePasswordSuccessDialog());
                  }
                  if (state is UserPasswordErrorState) {
                    Navigator.popUntil(context, (route) => route is! DialogRoute);
                    showAnimatedDialog1(context,
                        AppErrorDialog(content: state.failure.toString()));
                  }
                },
                child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text(AppStrings.ok)),
              )*/
              FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text(AppStrings.ok)),
            ],
          ),
        ),
      ),
    );
  }
}
