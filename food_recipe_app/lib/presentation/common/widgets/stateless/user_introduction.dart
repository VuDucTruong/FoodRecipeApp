import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class UserIntroduction extends StatelessWidget {
  const UserIntroduction({Key? key, required this.entity}) : super(key: key);
  final ChefEntity entity;
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
                border: Border.all(color: ColorManager.darkBlueColor),
                borderRadius: BorderRadius.circular(AppRadius.r20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => const AssetImage(
                    PicturePath.emptyAvatarPngPath,
                  ),
                  image: NetworkImage(
                    entity.profileInfo.avatarUrl,
                  ),
                )),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.all(AppMargin.m4),
                      child: Text(
                        entity.profileInfo.fullName,
                        maxLines: 3,
                        style: getBoldStyle(
                            color: Colors.black, fontSize: FontSize.s18),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(PicturePath.facebookPath),
                        const SizedBox(
                          width: AppSize.s8,
                        ),
                        Text(entity.profileInfo.facebookLink ?? "",
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
                        Text(entity.profileInfo.googleLink ?? '',
                            style: getRegularStyle(
                                color: Colors.black, fontSize: FontSize.s18))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
