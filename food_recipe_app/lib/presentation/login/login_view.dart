import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/network/error_handler.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/blocs/login/login_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late LoginBloc _loginBloc;
  @override
  void initState() {
    super.initState();
    _loginBloc = GetIt.instance<LoginBloc>();
    // _loginBloc.add(LoginButtonPressed('',''));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(children: [
              SvgPicture.asset(
                PicturePath.logoSVGPath,
                width: 133,
                height: 133,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 28),
              Text(AppStrings.continueWith.tr(),
                  style: getSemiBoldStyle(
                      color: Colors.black, fontSize: FontSize.s22)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getIconTextButton(
                    text: AppStrings.google.tr(),
                    iconPath: PicturePath.ggPath,
                    onPressed: () {
                      _loginBloc.add(LoginWithGooglePressed());
                    },
                  ),
                ],
              ),
              Text(AppStrings.or.tr(),
                  style: getSemiBoldStyle(
                      color: ColorManager.greyColor, fontSize: FontSize.s22)),
              Text(AppStrings.loginAccount.tr(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: getSemiBoldStyle(
                      color: Colors.black, fontSize: FontSize.s22)),
              const SizedBox(height: 4),
              _buildFormInput(),
              /*RememberCheckBox(isChecked: isRememberMe),*/
              const SizedBox(height: 8),
              BlocListener(
                bloc: _loginBloc,
                listener: (context, state) {
                  Navigator.popUntil(context, (route) => route is! DialogRoute);
                  if (state is LoginSuccess) {
                    Navigator.of(context).pushNamed(Routes.mainRoute);
                  } else if (state is LoginFailure) {
                    final failure = state.failure;
                    if (state is LoginWithGoogleFailure) {
                      if (failure.code == ResponseCode.BAD_REQUEST) {
                        Navigator.of(context).pushReplacementNamed(
                            Routes.createProfileRoute,
                            arguments: state.googleSignInAccount);
                        return;
                      }
                    }
                    debugPrint('failure: ${failure.code}: ${failure.message}');
                    handleBlocFailures(context, failure, () {
                      Navigator.of(context).pop();
                      setState(() {});
                    });
                  } else if (state is LoginLoading) {
                    showDialog(
                        context: context,
                        builder: (context) => const LoadingDialog());
                  }
                },
                child: Container(),
              ),
              _buildLoginButton(),
              const SizedBox(height: 16),
              _buildFooterText(
                prefix: AppStrings.notHaveAccount.tr(),
                suffix: AppStrings.signUp.tr(),
                context: context,
              ),
            ]),
          ),
        ),
      ),
    ));
  }

  Widget _buildFormInput() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CompulsoryTextField(
                content: AppStrings.email,
                validator: validateEmail,
                hint: AppStrings.enterEmail,
                controller: emailController),
            CompulsoryTextField(
                content: AppStrings.password,
                validator: validatePassword,
                isPassword: true,
                hint: AppStrings.enterPassword,
                controller: passwordController),
          ],
        ));
  }

  Widget _buildLoginButton() {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: FilledButton(
        onPressed: () {
          if (_formKey.currentState != null) {
            if (_formKey.currentState!.validate()) {
              _loginBloc.add(LoginButtonPressed(
                  email: emailController.text,
                  password: passwordController.text));
            }
          }
        },
        style: FilledButton.styleFrom(backgroundColor: ColorManager.blueColor),
        child: Center(
          child: Text(AppStrings.login.tr(),
              style: getMediumStyle(
                  color: ColorManager.darkBlueColor, fontSize: FontSize.s20)),
        ),
      ),
    );
  }
}

Widget _buildFooterText(
    {String suffix = '', String prefix = '', required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(prefix, style: getSemiBoldStyle(color: ColorManager.greyColor)),
      const SizedBox(
        width: 4,
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.createProfileRoute);
        },
        child: Text(suffix,
            style: getSemiBoldStyle(color: ColorManager.darkBlueColor)),
      ),
    ],
  );
}

Widget _getIconTextButton({
  String text = '',
  String? iconPath,
  Function()? onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath,
                width: 36, // Adjust the width as needed
                height: 36, // Adjust the height as needed
              ),
              const SizedBox(width: 8),
            ],
            Text(text,
                style: getSemiBoldStyle(
                    color: Colors.black, fontSize: FontSize.s14)),
          ],
        ),
      ),
    ),
  );
}
