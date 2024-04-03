import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class SelectionFoodImage extends StatefulWidget {
  SelectionFoodImage({super.key, required this.isVeg});
  MutableVariable<bool> isVeg;

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      Container(
        width: double.infinity,
        height: AppSize.s150,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(AppRadius.r20),
            border: Border.all(
                color: ColorManager.secondaryColor, width: AppSize.s2)),
        child: SvgPicture.asset(
          PicturePath.emptyRecipePath,
          fit: BoxFit.fill,
        ),
      ),
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
