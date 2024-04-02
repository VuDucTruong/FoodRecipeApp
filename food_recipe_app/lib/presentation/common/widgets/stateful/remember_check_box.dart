import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class RememberCheckBox extends StatefulWidget {
  MutableVariable<bool> isChecked;
  RememberCheckBox({super.key, required this.isChecked});
  @override
  _RememberCheckBoxState createState() => _RememberCheckBoxState();
}

class _RememberCheckBoxState extends State<RememberCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isChecked.value,
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
              widget.isChecked.value = !widget.isChecked.value;
            });
          },
          checkColor: Colors.white,
          side: const BorderSide(color: ColorManager.blueColor, width: 2),
        ),
        Text(AppStrings.rememberMe,
            style: getSemiBoldStyle(
                color: ColorManager.blueColor, fontSize: FontSize.s14)),
      ],
    );
  }
}
