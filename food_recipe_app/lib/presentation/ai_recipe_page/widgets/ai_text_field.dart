import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class AITextField extends StatelessWidget {
  const AITextField(
      {super.key,
      required this.title,
      required this.helperText,
      required this.textEditingController});
  final String title;
  final String helperText;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 3,
            style: getMediumStyle(
                fontSize: 16, color: ColorManager.secondaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
            maxLines: 5,
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 0, height: 0),
                hintText: helperText,
                focusedBorder: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(),
                border: const OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}
