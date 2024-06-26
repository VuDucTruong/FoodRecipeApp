import 'package:easy_localization/easy_localization.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/custom_text_form_field.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:lottie/lottie.dart';

import 'otp_item.dart';

class OTPVerifyingPage extends StatefulWidget {
  const OTPVerifyingPage(
      {super.key, required this.email, required this.navigateFunction});
  final String email;
  final Function navigateFunction;
  @override
  State<OTPVerifyingPage> createState() => _OTPVerifyingPageState();
}

class _OTPVerifyingPageState extends State<OTPVerifyingPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  int resetTime = 20;
  bool isReload = true;
  List<TextEditingController> controllerList = List.generate(
    6,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodeList = List.generate(
    6,
    (index) => FocusNode(),
  );

  void _handleChange(String value, int index) {
    if (value.length == 1 && index < 5) {
      // Move focus to the next field
      FocusScope.of(context).requestFocus(focusNodeList[index + 1]);
    } else if (value.length == 1 && index == 5) {
      // Optionally, you can perform the submit action here
      FocusScope.of(context).unfocus(); // Hide keyboard
    } else if (value.isEmpty && index > 0) {
      // Move focus to the previous field if the current field is empty
      FocusScope.of(context).requestFocus(focusNodeList[index - 1]);
    }
  }

  EmailOTP myAuth = EmailOTP();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendOTP(myAuth, widget.email);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var controller in controllerList) {
      controller.dispose();
    }
    for (var focusNode in focusNodeList) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String getOTP() {
    String otp = '';
    for (var controller in controllerList) {
      otp += controller.text;
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            AppStrings.otpVerifying.tr(),
            style:
                getBoldStyle(color: ColorManager.secondaryColor, fontSize: 20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              PicturePath.backArrowPath,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(LottiePath.sendOTPPath,
                width: width * 0.7, height: width * 0.7),
            Text(
              "${AppStrings.otpSent.tr()} ${widget.email}",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: getRegularStyle(fontSize: 16),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    6,
                    (index) => OPTItem(
                      focusNode: focusNodeList[index],
                      textEditingController: controllerList[index],
                      onTextChange: (p0) => _handleChange(p0, index),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(
                      width: width * 0.7,
                      child: FilledButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              bool isCorrect = myAuth.verifyOTP(otp: getOTP());
                              if (isCorrect) {
                                widget.navigateFunction.call();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(AppStrings.otpWrong.tr()),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(AppStrings.otpMissing.tr()),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Text(
                            AppStrings.verify.tr(),
                            style: getSemiBoldStyle(fontSize: 16),
                          ))),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.askOTP.tr(),
                          style: getRegularStyle(fontSize: 14)),
                      InkWell(
                        onTap: () {
                          if (!isReload) {
                            setState(() {
                              sendOTP(myAuth, widget.email);
                              isReload = true;
                            });
                          }
                        },
                        child: isReload
                            ? TweenAnimationBuilder(
                                tween: StepTween(begin: resetTime, end: 0),
                                duration: Duration(seconds: resetTime),
                                onEnd: () => setState(() {
                                  isReload = false;
                                }),
                                builder: (BuildContext context, int value,
                                    Widget? child) {
                                  return Text(
                                    "$value s",
                                    style: getSemiBoldStyle(
                                        fontSize: 14, color: Colors.red),
                                  );
                                },
                              )
                            : Text(AppStrings.resend.tr(),
                                style: getSemiBoldStyle(
                                        fontSize: 14,
                                        color: ColorManager.accentColor)
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 2,
                                        decorationColor:
                                            ColorManager.accentColor)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}

/**/
