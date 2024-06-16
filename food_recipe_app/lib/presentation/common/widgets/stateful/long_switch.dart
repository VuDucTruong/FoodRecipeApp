import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../stateless/gradient_text.dart';

class LongSwitch extends StatefulWidget {
  LongSwitch(
      {Key? key,
      required this.onContent,
      required this.offContent,
      required this.onColor,
      required this.offColor,
      required this.width,
      required this.height,
      required this.onChange,
      this.initialValue})
      : super(key: key);

  String onContent, offContent;
  Gradient onColor, offColor;
  double width, height;
  Function onChange;
  bool? initialValue;
  @override
  _LongSwitchState createState() {
    return _LongSwitchState();
  }
}

class _LongSwitchState extends State<LongSwitch> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      isOn = widget.initialValue!;
    }
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
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                widget.height,
              ),
              gradient: isOn ? widget.onColor : widget.offColor),
        ),
        Positioned(
          left: 10,
          child: AnimatedOpacity(
            opacity: isOn ? 1 : 0,
            duration: Durations.medium2,
            child: isOn
                ? GradientText(
                    widget.onContent,
                    gradient: ColorManager.linearGradientBlue,
                    style: getSemiBoldStyle(
                        color: Colors.black, fontSize: FontSize.s20),
                  )
                : Text(
                    widget.onContent,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkBlueColor,
                        fontSize: FontSize.s20),
                  ),
          ),
        ),
        Positioned(
          right: 10,
          child: AnimatedOpacity(
            opacity: isOn ? 0 : 1,
            duration: Durations.medium2,
            child: !isOn
                ? GradientText(
                    widget.offContent,
                    gradient: ColorManager.linearGradientBlue,
                    style: getSemiBoldStyle(
                        color: Colors.black, fontSize: FontSize.s20),
                  )
                : Text(
                    widget.offContent,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkBlueColor,
                        fontSize: FontSize.s20),
                  ),
          ),
        ),
        AnimatedPositioned(
          duration: Durations.medium2,
          curve: Curves.decelerate,
          left: isOn ? widget.width - widget.height : 0,
          child: InkWell(
            onTap: () {
              setState(() {
                widget.onChange.call();
                isOn = !isOn;
              });
            },
            child: Container(
              height: widget.height,
              width: widget.height,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isOn ? Colors.white : Colors.black,
                      width: widget.height / 4),
                  color: isOn ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(45)),
            ),
          ),
        ),
      ],
    );
  }
}
