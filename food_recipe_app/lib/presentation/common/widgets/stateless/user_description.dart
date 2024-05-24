import 'package:flutter/material.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class UserDescription extends StatefulWidget {
  const UserDescription({Key? key, required this.entity}) : super(key: key);
  final ChefEntity entity;

  @override
  State<UserDescription> createState() => _UserDescriptionState();
}

class _UserDescriptionState extends State<UserDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
        child: widget.entity.profileInfo.bio.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    child: Text(
                      maxLines: isExpanded ? 100 : 4,
                      widget.entity.profileInfo.bio,
                      style: getRegularStyle(color: Colors.black),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          !isExpanded
                              ? '${AppStrings.showMore} '
                              : '${AppStrings.showLess} ',
                          style:
                              getSemiBoldStyle(color: ColorManager.blueColor),
                        ),
                        !isExpanded
                            ? const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: ColorManager.blueColor,
                              )
                            : const Icon(
                                Icons.arrow_drop_up_rounded,
                                color: ColorManager.blueColor,
                              )
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: Text(
                  AppStrings.noBioInfor,
                  style:
                      getRegularStyle().copyWith(fontStyle: FontStyle.italic),
                ),
              ));
  }
}
