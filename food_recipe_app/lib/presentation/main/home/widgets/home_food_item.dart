import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/common_food_title.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class HomeFoodItem extends StatelessWidget {
  HomeFoodItem(
      {super.key,
      required this.width,
      required this.height,
      required this.title,
      required this.isVegan,
      required this.fontSize,
      required this.imageUrl});
  double width;
  double height;
  String title;
  double fontSize;
  String imageUrl;
  bool isVegan;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => {Navigator.pushNamed(context, Routes.detailFoodRoute)},
      child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(60),
                  bottom: Radius.circular(AppRadius.r18)),
              gradient: ColorManager.linearGradientPink),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 60, backgroundImage: NetworkImage(imageUrl)),
              /*Image.network(
                imageUrl,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(PicturePath.errorImagePath),
              ),*/
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timelapse_sharp, size: 14),
                          const SizedBox(
                            width: AppSize.s4,
                          ),
                          Text('10-20 mins',
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: fontSize))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.people, size: 14),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('4-5 people',
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: fontSize))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Gergous',
                            style: getSemiBoldStyle(
                                color: Colors.black, fontSize: fontSize),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(Icons.account_box_rounded, size: 14),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonFoodTitle(
                    isVegan: isVegan,
                    height: height * 0.12,
                    width: width * 0.9,
                    title: title,
                    fontSize: fontSize,
                  ),
                ],
              )
            ],
          )),
    );
    ;
  }
}
