import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class UserIntroduction extends StatelessWidget {
  const UserIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
}
