import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/object/update_follow_object.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

class ChefItem extends StatefulWidget {
  const ChefItem(
      {super.key, required this.chefEntity, required this.isFollowed});
  final ChefEntity chefEntity;
  final bool isFollowed;

  @override
  State<ChefItem> createState() => _ChefItemState();
}

class _ChefItemState extends State<ChefItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFollowed = widget.isFollowed;
  }

  bool isFollowed = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.8,
        children: [
          SlidableAction(
            onPressed: (_) {
              Navigator.pushNamed(context, Routes.chefProfileRoute,
                  arguments: widget.chefEntity.id);
            },
            backgroundColor: ColorManager.pinkColor,
            foregroundColor: Colors.white,
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(15)),
            icon: Icons.archive,
            label: AppStrings.chefProfile.tr(),
          ),
          SlidableAction(
            onPressed: (_) {
              setState(() {
                isFollowed = !isFollowed;
                GetIt.instance<VerifiedChefsBloc>().add(UpdateFollowChef(
                    UpdateFollowObject(widget.chefEntity.id, isFollowed)));
              });
            },
            backgroundColor: isFollowed
                ? ColorManager.secondaryColor
                : ColorManager.vegColor,
            foregroundColor: Colors.white,
            icon: isFollowed ? Icons.person_remove_alt_1 : Icons.person_add_alt,
            label:
                isFollowed ? AppStrings.unfollow.tr() : AppStrings.follow.tr(),
          ),
        ],
      ),
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.chefEntity.profileInfo.avatarUrl,
                    width: 100,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      PicturePath.emptyAvatarPngPath,
                      width: 100,
                      height: 100,
                    ),
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: Text(
                    widget.chefEntity.profileInfo.fullName,
                    style: getMediumStyle(fontSize: 16),
                  )),
                  SocialMediaItem(
                      iconPath: PicturePath.facebookPath,
                      link: widget.chefEntity.profileInfo.facebookLink ?? ''),
                  SocialMediaItem(
                      iconPath: PicturePath.gmailPath,
                      link: widget.chefEntity.profileInfo.googleLink ?? ''),
                  Row(
                    children: [
                      Text("${AppStrings.followers.tr()} : "),
                      Text(
                        widget.chefEntity.followerCount.toString(),
                        style: getMediumStyle(
                            color: ColorManager.blueColor, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
