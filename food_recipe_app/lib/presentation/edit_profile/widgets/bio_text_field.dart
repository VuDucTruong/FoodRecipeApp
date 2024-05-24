import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/edit_profile_input_decoration.dart';

import '../../resources/color_management.dart';
import '../../resources/string_management.dart';
import '../../resources/style_management.dart';

class BioTextField extends StatelessWidget {
  const BioTextField(
      {super.key, required this.controller, this.initialValue = ''});
  final TextEditingController controller;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.bio,
            style:
                getBoldStyle(color: ColorManager.secondaryColor, fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
              controller: controller,
              maxLines: null,
              minLines: 1,
              maxLength: 500,
              style: getLightStyle(color: Colors.black, fontSize: 16),
              decoration: editProfileInputDecoration()),
        ],
      ),
    );
  }
}
