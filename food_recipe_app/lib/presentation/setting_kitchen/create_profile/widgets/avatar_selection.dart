import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';

class AvatarSelection extends StatefulWidget {
  AvatarSelection({super.key,required this.selectedImage});
  MutableVariable<File?> selectedImage;
  @override
  _AvatarSelectionState createState() {
    return _AvatarSelectionState();
  }

}

class _AvatarSelectionState extends State<AvatarSelection> {
  File? myfile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        myfile = await selectImageFromGalery();
        widget.selectedImage.value = await selectImageFromGalery();
        setState(() {});
      },
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 133 / 2 + 4,
              backgroundImage: (widget.selectedImage.value == null
                  ? const AssetImage(PicturePath.emptyAvatarPngPath)
                  : FileImage(widget.selectedImage.value!)) as ImageProvider,
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset(
                  PicturePath.editPath,
                ))
          ],
        ),
      ),
    );
  }
}
