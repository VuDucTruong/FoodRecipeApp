import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';

class SelectionFoodImage extends StatefulWidget {
  SelectionFoodImage(
      {super.key, required this.isVeg, required this.fileList, this.url});
  MutableVariable<bool> isVeg;
  List<MultipartFile> fileList;
  String? url;
  @override
  _SelectionFoodImageState createState() {
    return _SelectionFoodImageState();
  }
}

class _SelectionFoodImageState extends State<SelectionFoodImage> {
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
    return Stack(children: [
      InkWell(
          onTap: () async {
            selectedImage = await selectImageFromGalery();
            if (selectedImage != null) {
              MultipartFile temp =
                  await MultipartFile.fromFile(selectedImage!.path);
              setState(() {
                widget.fileList.add(temp);
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: AppSize.s150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r20),
                color: Colors.white70,
                border: Border.all(
                    color: ColorManager.secondaryColor, width: AppSize.s2)),
            child: selectedImage == null
                ? widget.url == null
                    ? const Icon(
                        Icons.add_a_photo_outlined,
                        size: 100,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          widget.url!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(PicturePath.emptyRecipePath),
                        ))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    )),
          )),
      Positioned(
        bottom: 5,
        left: 10,
        child: InkWell(
          child: CircleAvatar(
            radius: AppRadius.r15,
            backgroundColor: widget.isVeg.value
                ? ColorManager.vegColor
                : ColorManager.nonVegColor,
          ),
          onTap: () {
            setState(() {
              widget.isVeg.value = !widget.isVeg.value;
            });
          },
        ),
      )
    ]);
  }
}
