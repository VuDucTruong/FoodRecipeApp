import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class DefaultHeads extends StatefulWidget {
  DefaultHeads({super.key, required this.headNumber});
  MutableVariable headNumber;
  @override
  _DefaultHeadsState createState() {
    return _DefaultHeadsState();
  }
}

class _DefaultHeadsState extends State<DefaultHeads> {
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
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r15),
                color: Colors.grey.shade300),
            width: AppSize.s120,
            height: AppSize.s30,
            child: Center(
              child: Text(
                '${widget.headNumber.value}',
                style:
                    getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
              ),
            )),
        Positioned(
          left: 0,
          child: Container(
            width: AppSize.s30,
            height: AppSize.s30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: ColorManager.linearGradientPink),
            child: Center(
              child: IconButton(
                  iconSize: AppSize.s16,
                  onPressed: () {
                    setState(() {
                      widget.headNumber.value--;
                    });
                  },
                  icon: const Icon(Icons.remove)),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: AppSize.s30,
            height: AppSize.s30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r10),
                gradient: ColorManager.linearGradientDarkBlue),
            child: Center(
              child: IconButton(
                  iconSize: AppSize.s16,
                  onPressed: () {
                    setState(() {
                      widget.headNumber.value++;
                    });
                  },
                  icon: const Icon(Icons.add)),
            ),
          ),
        ),
      ],
    );
  }
}
