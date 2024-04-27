import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_description.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_introduction.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_social_status.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';
import '../resources/style_management.dart';
import '../resources/value_manament.dart';

class ChefProfileView extends StatefulWidget {
  const ChefProfileView({super.key});

  @override
  _ChefProfileViewState createState() {
    return _ChefProfileViewState();
  }
}

class _ChefProfileViewState extends State<ChefProfileView> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.verifiedChefs,
          style: getBoldStyle(
              color: ColorManager.secondaryColor, fontSize: FontSize.s20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            PicturePath.backArrowPath,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(AppMargin.m8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserIntroduction(),
              const UserDescription(),
              const UserSocialStatus(),
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
                            color: Colors.white, fontSize: FontSize.s16)),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: ColorManager.blueColor,
                            style: BorderStyle.solid,
                            width: 2)),
                    child: Text(AppStrings.requestRecipe,
                        style: getBoldStyle(
                            color: ColorManager.blueColor,
                            fontSize: FontSize.s16)),
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
                  return Container();
                  /*return RecipeItem(isUser: false);*/
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
