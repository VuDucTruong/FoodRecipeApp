import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/edit_profile/widgets/edit_profile_input_decoration.dart';

import '../../../app/functions.dart';
import '../../resources/color_management.dart';
import '../../resources/string_management.dart';
import '../../resources/style_management.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String initialValue;

  const NameTextField(
      {super.key, required this.controller, this.initialValue = ''});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.fullName.tr(),
            style:
                getBoldStyle(color: ColorManager.secondaryColor, fontSize: 16),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateEmpty,
              maxLines: null,
              minLines: 1,
              maxLength: 50,
              style: getLightStyle(color: Colors.black, fontSize: 16),
              decoration: editProfileInputDecoration()),
        ],
      ),
    );
  }
}
