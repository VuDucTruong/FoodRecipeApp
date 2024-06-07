import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class OPTItem extends StatelessWidget {
  const OPTItem(
      {super.key,
      required this.textEditingController,
      required this.focusNode,
      required this.onTextChange});
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function(String) onTextChange;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
        maxLength: 1,
        validator: validateEmpty,
        onChanged: onTextChange,
        style: getSemiBoldStyle(fontSize: 20),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            isDense: true,
            counterStyle: const TextStyle(
              fontSize: 0,
            ),
            constraints: BoxConstraints.tight(const Size(48, 64)),
            errorStyle: const TextStyle(fontSize: 0),
            helperStyle: const TextStyle(fontSize: 0),
            counter: null,
            focusedBorder: otpInputBorder(),
            enabledBorder: otpInputBorder(),
            border: otpInputBorder()),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

OutlineInputBorder otpInputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.secondaryColor, width: 2),
    borderRadius: BorderRadius.circular(8),
  );
}
