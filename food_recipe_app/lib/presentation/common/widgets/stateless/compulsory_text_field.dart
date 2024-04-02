import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/custom_text_form_field.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class CompulsoryTextField extends StatelessWidget {
  CompulsoryTextField(
      {super.key,
      required this.content,
      required this.validator,
      this.icon,
      required this.hint,
      required this.controller});
  String content;
  String? Function(String? x) validator;
  Widget? icon;
  String hint;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                style: getSemiBoldStyle(
                    color: Colors.black, fontSize: FontSize.s16),
                children: [
              TextSpan(text: content),
              TextSpan(
                text: " *",
                style:
                    getSemiBoldStyle(color: Colors.red, fontSize: FontSize.s16),
              ),
            ])),
        const SizedBox(
          height: AppSize.s4,
        ),
        CustomTextFormField(
          controller: controller,
          validator: validator,
          hint: hint,
          icon: icon,
        ),
      ],
    );
  }
}
