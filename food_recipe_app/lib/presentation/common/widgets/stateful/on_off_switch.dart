import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:food_recipe_app/presentation/utils/notification_helper.dart';
import 'package:get_it/get_it.dart';

class OnOffSwitch extends StatefulWidget {
  OnOffSwitch({Key? key, required this.isOn}) : super(key: key);
  MutableVariable<bool> isOn;
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

  int times = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: AppSize.s80,
          height: AppSize.s30,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer)
              ],
              borderRadius: BorderRadius.circular(
                AppRadius.r30,
              ),
              color: Colors.white),
        ),
        Positioned(
          left: 5,
          child: AnimatedOpacity(
            opacity: widget.isOn.value ? 1 : 0,
            duration: Durations.medium2,
            child: Text(AppStrings.on.tr(),
                style: getRegularStyle(
                    color: Colors.black, fontSize: FontSize.s20)),
          ),
        ),
        Positioned(
          right: 5,
          child: AnimatedOpacity(
            opacity: widget.isOn.value ? 0 : 1,
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
          left: widget.isOn.value ? 50 : 0,
          child: InkWell(
            onTap: () async {
              bool isNotifcation = await GetIt.instance<NotificationHelper>()
                  .requestNotificationPermission();
              if (isNotifcation != widget.isOn.value) {
                setState(() {
                  widget.isOn.value = !widget.isOn.value;
                });
              } else {
                times++;
                if (times >= 2) {
                  if (context.mounted) {
                    showAnimatedDialog1(
                        context,
                        AppErrorDialog(
                            content:
                                "Notification permisstion is disabled \n Please enable it in application settings"));
                  }
                }
              }
            },
            child: Container(
              height: AppSize.s30,
              width: AppSize.s30,
              decoration: BoxDecoration(
                  gradient: widget.isOn.value
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
