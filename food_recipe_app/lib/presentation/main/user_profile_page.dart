import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/widgets/widget.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../resources/font_manager.dart';
import '../resources/route_management.dart';
import '../resources/value_manament.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() {
    return _UserProfilePageState();
  }
}

class _UserProfilePageState extends State<UserProfilePage> {
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
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(AppMargin.m8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.verifiedChefs,
              style: getBoldStyle(
                  color: ColorManager.secondaryColor, fontSize: FontSize.s20),
            ),
            getUserIntro(),
            getUserDescription(),
            getUserSocialStatus(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(style: BorderStyle.none),
                      backgroundColor: ColorManager.secondaryColor),
                  child: Text(AppStrings.addRecipe,
                      style: getBoldStyle(
                        color: Colors.white,
                      )),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.editProfileRoute);
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: ColorManager.blueColor,
                          style: BorderStyle.solid,
                          width: 1)),
                  child: Text(AppStrings.editProfile,
                      style: getBoldStyle(
                        color: ColorManager.blueColor,
                      )),
                ),
              ],
            ),
            const Divider(
              color: Colors.black26,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return getRecipeItem(context, true);
              },
            ))
          ],
        ),
      ),
    );
  }
}
