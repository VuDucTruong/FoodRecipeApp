import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/object/update_follow_object.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/comon_follow_button.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

class ChefItem extends StatelessWidget {
  const ChefItem(
      {super.key, required this.chefEntity, required this.isFollowed});
  final ChefEntity chefEntity;
  final bool isFollowed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.chefProfileRoute,
            arguments: chefEntity.id);
      },
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    chefEntity.profileInfo.avatarUrl,
                    width: 100,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      PicturePath.emptyAvatarPngPath,
                      width: 100,
                      height: 100,
                    ),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      chefEntity.profileInfo.fullName,
                      style: getMediumStyle(fontSize: 16),
                    )),
                SocialMediaItem(
                    iconPath: PicturePath.facebookPath,
                    link: chefEntity.profileInfo.facebookLink ?? ''),
                SocialMediaItem(
                    iconPath: PicturePath.gmailPath,
                    link: chefEntity.profileInfo.googleLink ?? ''),
                Row(
                  children: [
                    Text("${AppStrings.followers.tr()} : "),
                    Text(
                      chefEntity.followerCount.toString(),
                      style: getMediumStyle(
                          color: ColorManager.blueColor, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            CommonFollowButton(
              chefEntity: chefEntity,
              onPressed: () {
                GetIt.instance<VerifiedChefsBloc>().add(UpdateFollowChef(
                    UpdateFollowObject(chefEntity.id, !isFollowed)));
              },
            ),
            const SizedBox(
              width: 4,
            )
          ],
        ),
      ),
    );
  }
}

class SocialMediaItem extends StatelessWidget {
  String iconPath;
  String link;

  SocialMediaItem({super.key, required this.iconPath, required this.link});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(
            width: 8,
          ),
          Text(link)
        ],
      ),
    );
  }
}
