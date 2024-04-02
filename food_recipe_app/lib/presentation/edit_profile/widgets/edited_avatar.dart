import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class EditedAvatar extends StatefulWidget {
  const EditedAvatar({super.key});

  @override
  _EditedAvatarState createState() {
    return _EditedAvatarState();
  }
}

class _EditedAvatarState extends State<EditedAvatar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        selectedImage = await selectImageFromGalery();
        setState(() {});
      },
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 133 / 2 + 4,
                backgroundImage: (selectedImage == null
                    ? const AssetImage(PicturePath.emptyAvatarPngPath)
                    : FileImage(selectedImage!)) as ImageProvider,
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    PicturePath.editPath,
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppStrings.editPicture,
            style: getRegularStyle(
                color: ColorManager.blueColor, fontSize: FontSize.s14),
          )
        ],
      ),
    );
  }
}
