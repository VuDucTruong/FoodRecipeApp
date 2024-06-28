import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/utils/gemini_utils.dart';

class ImageListWidget extends StatefulWidget {
  const ImageListWidget({super.key, required this.userPrompt});
  final PromptData userPrompt;

  @override
  _ImageListWidgetState createState() {
    return _ImageListWidgetState();
  }
}

class _ImageListWidgetState extends State<ImageListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  File? imageFile;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      runSpacing: 4,
      spacing: 4,
      children: [
        ...widget.userPrompt.images.map(
          (e) => Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorManager.accentColor, width: 2),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(e),
                      fit: BoxFit.fill,
                      onError: (exception, stackTrace) =>
                          Image.asset(PicturePath.emptyRecipePath),
                    )),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.userPrompt.images
                          .removeWhere((el) => el.path == e.path);
                    });
                  },
                  child: const Icon(
                    Icons.highlight_remove_rounded,
                    size: 24,
                  ),
                ),
              )
            ],
          ),
        ),
        InkWell(
            onTap: () async {
              imageFile = await selectImageFromGalery();
              if (imageFile != null) {
                widget.userPrompt.images.add(imageFile!);
                setState(() {});
              }
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.add_a_photo_outlined,
                color: ColorManager.greyColor,
                size: 80,
              ),
            )),
      ],
    );
  }
}
