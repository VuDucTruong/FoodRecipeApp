import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

class CommonFollowButton extends StatefulWidget {
  const CommonFollowButton(
      {super.key, required this.onPressed, required this.chefEntity});

  final Function onPressed;
  final ChefEntity chefEntity;

  @override
  _CommonFollowButtonState createState() {
    return _CommonFollowButtonState();
  }
}

class _CommonFollowButtonState extends State<CommonFollowButton> {
  bool isFollowed = false;
  BackgroundUser backgroundUser =
      GetIt.instance<BackgroundDataManager>().getBackgroundUser();
  bool isUser = false;
  @override
  void initState() {
    super.initState();
    isFollowed = backgroundUser.followingIds.contains(widget.chefEntity);
    isUser = backgroundUser.id == widget.chefEntity.id;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Visibility(
      visible: !isUser,
      child: FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: isFollowed ? null : ColorManager.vegColor),
          onPressed: () {
            setState(() {
              isFollowed = !isFollowed;
              widget.onPressed.call();
            });
          },
          child: isFollowed
              ? Text(
                  AppStrings.unfollow,
                  style: getMediumStyle(color: Colors.white, fontSize: 14),
                )
              : Text(
                  AppStrings.follow,
                  style: getMediumStyle(color: Colors.white, fontSize: 14),
                )),
    );
  }
}