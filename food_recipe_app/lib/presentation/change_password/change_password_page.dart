import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/change_password/bloc/change_password_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:get_it/get_it.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ChangePasswordBloc _changePasswordBloc;

  @override
  void initState() {
    super.initState();
    _changePasswordBloc = GetIt.instance<ChangePasswordBloc>();
  }

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
              BlocConsumer(
                bloc: _changePasswordBloc,
                listener: (BuildContext context, Object? state) {
                  Navigator.popUntil(context, (route) => route is! DialogRoute);
                  if (state is ChangePasswordLoading) {
                    showDialog(
                        context: context,
                        builder: (context) => const LoadingDialog());
                  } else if (state is ChangePasswordSuccess) {
                    showDialog(
                        context: context,
                        builder: (context) => CongratulationDialog(
                              content: "Change password successfully",
                            ));
                  } else if (state is ChangePasswordFailure) {
                    final failure = state.failure;
                    handleBlocFailures(context, failure, () {});
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          CompulsoryTextField(
                            content: AppStrings.newPassword,
                            validator: validatePassword,
                            hint: AppStrings.hintOldPassword,
                            controller: oldPasswordController,
                            isPassword: true,
                            isCompulsory: true,
                          ),
                          CompulsoryTextField(
                            content: "Confirm new password",
                            validator: validatePassword,
                            hint: AppStrings.hintNewPassword,
                            controller: newPasswordController,
                            isPassword: true,
                            isCompulsory: true,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (!validateMatch(oldPasswordController.text,
                          newPasswordController.text)) {
                        showDialog(
                            context: context,
                            builder: (context) => AppErrorDialog(
                                content: AppStrings.notMatchPass));
                      } else {
                        debugPrint("Change password aslkdjflkasjdl");
                        _changePasswordBloc.add(ChangePasswordSubmitEvent(
                            newPasswordController.text));
                      }
                    }
                  },
                  child: const Text(AppStrings.ok)),
            ],
          ),
        ),
      ),
    );
  }

  bool validateMatch(String value1, String value2) {
    if (value1 != value2) {
      return false;
    }
    return true;
  }
}
