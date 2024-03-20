import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/common/widgets/widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/comon_text_input.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    CommonTextInput emailInput = CommonTextInput(
      label: AppStrings.email,
      controller: emailController,
      hintText: 'Enter your ${AppStrings.email}',
      isRequired: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your ${AppStrings.email}';
        }
        return '';
      },
    );
    CommonTextInput passwordInput = CommonTextInput(
      label: AppStrings.password,
      controller: passwordController,
      hintText: 'Enter your ${AppStrings.password}',
      isObscure: true,
      isRequired: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your ${AppStrings.password}';
        }
        return '';
      },
    );
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
              const Text(
                AppStrings.continueWith,
                style: TextStyle(
                  fontFamily: interFontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconTextButton(
                      text: AppStrings.facebook,
                      iconPath: PicturePath.fbPath,
                      width: 120,
                      height: 50,
                      onPressed: () {},
                    ),
                    _buildIconTextButton(
                      text: AppStrings.google,
                      iconPath: PicturePath.ggPath,
                      width: 120,
                      height: 50,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                AppStrings.or,
                style: TextStyle(
                  color: Color.fromARGB(90, 0, 0, 0),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                AppStrings.createAccount,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              emailInput,
              passwordInput,
              const SizedBox(height: 8),
              getSubmitButton(AppStrings.signUp),
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
}

Widget _buildFooterText(
    {String suffix = '', String prefix = '', required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        prefix,
        style: TextStyle(
          color: ColorManager.greyColor,
          fontFamily: interFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
        },
        child: Text(
          suffix,
          style: const TextStyle(
            color: ColorManager.darkBlueColor,
            fontFamily: interFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

Widget _buildIconTextButton({
  String text = '',
  String? iconPath,
  Function()? onPressed,
  double width = 50,
  double height = 50,
  double? maxWidth,
  double? maxHeight,
}) {
  return Container(
    width: width,
    height: height,
    decoration: getBoxDecorationShadow(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
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
          Text(
            text,
            style: const TextStyle(
              color: ColorManager.darkBlueColor,
              fontFamily: interFontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
