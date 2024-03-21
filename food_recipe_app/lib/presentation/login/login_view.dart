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
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
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
              Text(AppStrings.continueWith,
                  style: getSemiBoldStyle(
                      color: Colors.black, fontSize: FontSize.s22)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getIconTextButton(
                    text: AppStrings.facebook,
                    iconPath: PicturePath.fbPath,
                    onPressed: () {},
                  ),
                  _getIconTextButton(
                    text: AppStrings.google,
                    iconPath: PicturePath.ggPath,
                    onPressed: () {},
                  ),
                ],
              ),
              Text(AppStrings.or,
                  style: getSemiBoldStyle(
                      color: ColorManager.greyColor, fontSize: FontSize.s22)),
              Text(AppStrings.createAccount,
                  style: getSemiBoldStyle(
                      color: Colors.black, fontSize: FontSize.s22)),
              const SizedBox(height: 4),
              emailInput,
              passwordInput,
              _RememberMeButton(),
              const SizedBox(height: 8),
              getSubmitButton(AppStrings.login),
              const SizedBox(height: 16),
              _buildFooterText(
                prefix: AppStrings.notHaveAccount,
                suffix: AppStrings.signUp,
                context: context,
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}

class _RememberMeButton extends StatefulWidget {
  bool isChecked;
  final ValueChanged<bool>? onChanged;
  _RememberMeButton({Key? key, this.isChecked = false, this.onChanged})
      : super(key: key);
  @override
  _RememberMeButtonState createState() => _RememberMeButtonState();
}

class _RememberMeButtonState extends State<_RememberMeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: widget.isChecked,
            // make the inner fill blue only when checked
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return ColorManager.blueColor;
                }
                return Colors.white;
              },
            ),
            onChanged: (value) {
              setState(() {
                widget.onChanged?.call(value ??
                    false); // Update the check state through the callback
              });
            },
            checkColor: Colors.white,
            side: const BorderSide(color: ColorManager.blueColor, width: 2),
          ),
          Text(AppStrings.rememberMe,
              style: getSemiBoldStyle(
                  color: ColorManager.blueColor, fontSize: FontSize.s14)),
        ],
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
          Navigator.of(context).pushReplacementNamed(Routes.signUpRoute);
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
