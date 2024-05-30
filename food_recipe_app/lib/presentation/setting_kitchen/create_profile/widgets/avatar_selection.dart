import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';

class AvatarSelection extends StatefulWidget {
  AvatarSelection({super.key, required this.selectedImage, this.imageUrl});
  MutableVariable<MultipartFile?> selectedImage;
  String? imageUrl;
  @override
  _AvatarSelectionState createState() {
    return _AvatarSelectionState();
  }
}

class _AvatarSelectionState extends State<AvatarSelection> {
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
        if (selectedImage != null) {
          widget.selectedImage.value =
              await MultipartFile.fromFile(selectedImage!.path);
          setState(() {});
        }
      },
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 133 / 2 + 4,
              backgroundImage: (selectedImage == null
                  ? (widget.imageUrl != null
                      ? NetworkImage(widget.imageUrl!)
                      : const AssetImage(PicturePath.emptyAvatarPngPath))
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
      ),
    );
  }
}
