import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/compulsory_text_field.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/comon_text_input.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isRememberMe = false;

  @override
  void dispose() {
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
              Text(AppStrings.continueWith,
                  style: getSemiBoldStyle(
                      color: Colors.black, fontSize: FontSize.s22)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getconTextButton(
                    text: AppStrings.facebook,
                    iconPath: PicturePath.fbPath,
                    onPressed: () {},
                  ),
                  _getconTextButton(
                    text: AppStrings.google,
                    iconPath: PicturePath.ggPath,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(AppStrings.or,
                  style: getSemiBoldStyle(
                      color: ColorManager.greyColor, fontSize: FontSize.s20)),
              Text(AppStrings.createAccount,
                  style: getSemiBoldStyle(
                      color: Colors.black, fontSize: FontSize.s20)),
              const SizedBox(height: 4),
              _buildFormInput(),
              const SizedBox(height: 12),
              _buildSignUpButton(),
              const SizedBox(height: 16),
              _buildFooterText(
                prefix: AppStrings.alreadyHaveAccount,
                suffix: AppStrings.login,
                context: context,
              ),
            ]),
          ),
        ),
      ),
    ));
  }

  Widget _buildSignUpButton() {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: FilledButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pushNamed(context, Routes.settingKitchenRoute);
          }
        },
        style: FilledButton.styleFrom(backgroundColor: ColorManager.blueColor),
        child: Center(
          child: Text(AppStrings.signUp,
              style: getMediumStyle(
                  color: ColorManager.darkBlueColor, fontSize: FontSize.s20)),
        ),
      ),
    );
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
                hint: AppStrings.enterPassword,
                controller: passwordController),
          ],
        ));
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
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          },
          child: Text(suffix,
              style: getSemiBoldStyle(color: ColorManager.darkBlueColor)),
        ),
      ],
    );
  }

  Widget _getconTextButton({
    String text = '',
    String? iconPath,
    Function()? onPressed,
  }) {
    return Card(
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
    );
  }
}
