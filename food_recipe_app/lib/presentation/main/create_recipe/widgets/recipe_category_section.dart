import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/presentation/main/create_recipe/widgets/category_list_view.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class RecipeCategorySection extends StatefulWidget {
  List<String> selectedCategoryList;

  RecipeCategorySection({super.key, required this.selectedCategoryList});

  @override
  _RecipeCategorySectionState createState() {
    return _RecipeCategorySectionState();
  }
}

class _RecipeCategorySectionState extends State<RecipeCategorySection> {
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
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              width: 28,
              height: 28,
              PicturePath.recipeCategoryPath,
              colorFilter: const ColorFilter.mode(
                  ColorManager.secondaryColor, BlendMode.srcIn),
            ),
            const SizedBox(
              width: AppSize.s12,
            ),
            Text(
              AppStrings.foodCategory.tr(),
              style: getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
            ),
            const Spacer(),
            FilledButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryListView(
                            selectedCategoryList: widget.selectedCategoryList),
                      ));
                  setState(() {});
                },
                child: Row(
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(AppStrings.addCategories.tr())
                  ],
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            maxLines: 3,
            widget.selectedCategoryList.join(' , '),
            style: getMediumStyle(color: Colors.grey, fontSize: 16)
                .copyWith(fontStyle: FontStyle.italic),
          ),
        )
      ],
    );
  }
}
