import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class FoodItem extends StatefulWidget {
  FoodItem({
    super.key,
    required this.width,
    required this.foodTypeMap,
    required this.foodName,
  });
  double width;
  Map<String, bool> foodTypeMap;
  String foodName;
  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool? isSelected = widget.foodTypeMap[widget.foodName];
    return InkWell(
      onTap: () {
        setState(() {
          widget.foodTypeMap[widget.foodName] = !isSelected!;
        });
      },
      child: AnimatedOpacity(
        duration: Durations.medium1,
        opacity: widget.foodTypeMap[widget.foodName] ?? false ? 1 : 0.6,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              alignment: Alignment.center,
              width: widget.width,
              height: 35,
              decoration: BoxDecoration(
                  color: ColorManager.whiteOrangeColor,
                  borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: widget.width * 0.8,
                child: Text(
                  widget.foodName,
                  overflow: TextOverflow.clip,
                  style: getSemiBoldStyle(
                      color: ColorManager.darkBlueColor,
                      fontSize: FontSize.s18),
                ),
              ),
            ),
            Container(
              width: 13,
              height: 13,
              transform: Matrix4.translationValues(-5, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorManager.lightBG,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside),
                  borderRadius: BorderRadius.circular(AppRadius.r45),
                  gradient: ColorManager.linearGradientDarkBlue),
            ),
          ],
        ),
      ),
    );
  }
}
