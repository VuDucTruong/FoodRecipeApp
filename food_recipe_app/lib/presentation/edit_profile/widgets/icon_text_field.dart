import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/edit_profile_input_decoration.dart';

import '../../resources/style_management.dart';

class IconTextField extends StatelessWidget {
  const IconTextField(
      {super.key,
      required this.controller,
      required this.content,
      required this.iconPath,
      this.intialValue = ''});
  final TextEditingController controller;
  final String content;
  final String iconPath;
  final String intialValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 100,
              child: Row(
                children: [
                  SvgPicture.asset(iconPath),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(content,
                      style: getBoldStyle(color: Colors.black, fontSize: 14)),
                ],
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextFormField(
                controller: controller,
                style: getLightStyle(color: Colors.black, fontSize: 16),
                maxLines: null,
                minLines: 1,
                decoration: editProfileInputDecoration()),
          ),
        ],
      ),
    );
  }
}
