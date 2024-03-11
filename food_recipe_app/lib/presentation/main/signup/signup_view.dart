import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/common/state_render/state_render.dart';
import 'package:food_recipe_app/presentation/common/widgets/widget.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView>{
  @override
  Widget build(BuildContext context) {
    CommonTextInput emailInput = CommonTextInput(
      label: 'Email',
      hintText: 'Enter your email',
      isRequired: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        return '';
      },
    );
    CommonTextInput passwordInput = CommonTextInput(
      label: 'Password',
      hintText: 'Enter your password',
      isObscure: true,
      isRequired: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
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
              child: Column(
                children:[
                  SvgPicture.asset(
                    PicturePath.logoSVGPath,
                    width: 133,
                    height: 133,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Continue with',
                    style: TextStyle(
                      fontFamily: interFontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 37),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconTextButton(
                          text: 'Facebook',
                          iconPath: PicturePath.fbPath,
                          width: 120,
                          height: 50,
                          onPressed: () {},
                        ),
                        _buildIconTextButton(
                          text: 'Google',
                          iconPath: PicturePath.ggPath,
                          width: 120,
                          height: 50,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
            
                  const SizedBox(height: 20),
                  const Text('Or',style: TextStyle(
                    color: Color.fromARGB(90, 0, 0, 0),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),),
                  const Text('Create your account',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                  const SizedBox(height:4),
                  emailInput,
                  passwordInput,
                  _RememberMeButton(),
                  const SizedBox(height: 8),
                  getSubmitButton('Sign up'),
                  const SizedBox(height: 16),
                  _buildFooterText(
                    prefix: 'Already have an account? ',
                    suffix: 'Login',
                  ),
                ]
              ),
            ),
          ),
            ),
      )
    );
  }
}

class _RememberMeButton extends StatefulWidget {
  bool isChecked ;
  _RememberMeButton({Key? key,this.isChecked = false}) : super(key: key);
  @override
  _RememberMeButtonState createState() => _RememberMeButtonState();
}

class _RememberMeButtonState extends State<_RememberMeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8),
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
                widget.isChecked = value!;
              });
            },
            checkColor: Colors.white,
            side: const BorderSide(color: ColorManager.blueColor, width: 2),
          ),
          const Text(
            'Remember me',
            style: TextStyle(
              color: ColorManager.blueColor,
              fontFamily: interFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }

}

Widget _buildFooterText({String suffix = '',String prefix = ''}){
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
      Text(
        suffix,
        style: const TextStyle(
          color: ColorManager.darkBlueColor,
          fontFamily: interFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
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
    // constraints: BoxConstraints(
    //   maxWidth: maxWidth?? width,
    //   maxHeight: maxHeight?? height,
    // ),
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

