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
  EditedAvatar({super.key, required this.avatarUrl, this.selectedImage});
  final String avatarUrl;
  File? selectedImage;
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        widget.selectedImage = await selectImageFromGalery();
        setState(() {});
      },
      child: Column(
        children: [
          Stack(
            children: [
              ClipOval(
                child: Container(
                    width: 135,
                    height: 135,
                    color: Colors.white,
                    child: widget.selectedImage == null
                        ? Image.network(
                            widget.avatarUrl,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  PicturePath.emptyAvatarPngPath);
                            },
                          )
                        : Image.file(widget.selectedImage!)),
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
