import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class OnOffSwitch extends StatefulWidget {
  const OnOffSwitch({Key? key}) : super(key: key);

  @override
  _OnOffSwitchState createState() {
    return _OnOffSwitchState();
  }
}

class _OnOffSwitchState extends State<OnOffSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      textDirection: TextDirection.ltr,
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: AppSize.s80,
          height: AppSize.s30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppRadius.r30,
              ),
              color: Colors.white),
        ),
        Positioned(
          left: 5,
          child: AnimatedOpacity(
            opacity: isOn ? 1 : 0,
            duration: Durations.medium2,
            child: Text(AppStrings.on,
                style: getRegularStyle(
                    color: Colors.black, fontSize: FontSize.s20)),
          ),
        ),
        Positioned(
          right: 5,
          child: AnimatedOpacity(
            opacity: isOn ? 0 : 1,
            duration: Durations.medium2,
            child: Text(
              AppStrings.off,
              style:
                  getRegularStyle(color: Colors.black, fontSize: FontSize.s20),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Durations.medium2,
          curve: Curves.decelerate,
          left: isOn ? 50 : 0,
          child: InkWell(
            onTap: () {
              setState(() {
                isOn = !isOn;
              });
            },
            child: Container(
              height: AppSize.s30,
              width: AppSize.s30,
              decoration: BoxDecoration(
                  gradient: isOn
                      ? ColorManager.linearGradientDarkBlue
                      : ColorManager.linearGradientPink,
                  borderRadius: BorderRadius.circular(45)),
            ),
          ),
        ),
      ],
    );
  }
}
