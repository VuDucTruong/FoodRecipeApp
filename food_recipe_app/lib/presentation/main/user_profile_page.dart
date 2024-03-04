import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/widgets/widget.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../resources/font_manager.dart';
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
              AppStrings.yourProfile,
              style: getBoldStyle(
                  color: ColorManager.secondaryColor, fontSize: FontSize.s20),
            ),
            _getUserIntro(),
            _getUserDescription(),
            _getUserSocialStatus(),
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
                      side: BorderSide(
                          color: ColorManager.blueColor,
                          style: BorderStyle.solid,
                          width: 1)),
                  child: Text(AppStrings.editProfile,
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
                return _getRecipeItem();
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget _getUserSocialStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '5',
                style:
                    getBoldStyle(color: Colors.black, fontSize: FontSize.s16),
              ),
              const SizedBox(
                height: AppSize.s4,
              ),
              Text(
                AppStrings.recipes,
                style: TextStyle(
                    color: ColorManager.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.s16),
              )
            ],
          ),
          Column(
            children: [
              Text('2.8k',
                  style: getBoldStyle(
                      color: Colors.black, fontSize: FontSize.s16)),
              Text(
                AppStrings.followers,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s16),
              )
            ],
          ),
          Column(
            children: [
              Text('321',
                  style: getBoldStyle(
                      color: Colors.black, fontSize: FontSize.s16)),
              Text(
                AppStrings.following,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s16),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _getUserDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
      child: const Text(
          'Hola! I’m Claudia, a passionate chef and a part time designer. I learnt cooking '
          'from my grandmother and mom...'),
    );
  }

  Widget _getUserIntro() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 144,
            width: 144,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(AppRadius.r20)),
          ),
          Container(
            margin: const EdgeInsets.all(AppMargin.m8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.all(AppMargin.m4),
                    child: Text(
                      'Name',
                      style: getBoldStyle(
                          color: Colors.black, fontSize: FontSize.s18),
                    )),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_rounded),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      Text('Mexico',
                          style: getRegularStyle(
                              color: Colors.black, fontSize: FontSize.s18))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(PicturePath.instagramPath),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      Text('@instagram',
                          style: getRegularStyle(
                              color: Colors.black, fontSize: FontSize.s18))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(PicturePath.gmailPath),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      Text('@gmai.com',
                          style: getRegularStyle(
                              color: Colors.black, fontSize: FontSize.s18))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRecipeItem() {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m4, horizontal: AppMargin.m12),
      child: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(AppRadius.r20)),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: getTitleFoodName(MediaQuery.of(context).size.width * 0.8,
                  40, 20, ColorManager.darkBlueColor, FontSize.s20))
        ],
      ),
    );
  }
}
