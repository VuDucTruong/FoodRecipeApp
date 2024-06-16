import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

class CategoryListView extends StatefulWidget {
  CategoryListView({super.key, required this.selectedCategoryList});
  List<String> selectedCategoryList;
  @override
  _CategoryListViewState createState() {
    return _CategoryListViewState();
  }
}

class _CategoryListViewState extends State<CategoryListView> {
  List<String> categoryList = Constant.typeList;
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
        title: Text(AppStrings.foodCategory.tr()),
      ),
      body: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) => CheckboxListTile(
            title: Text(
              categoryList[index],
              style: getMediumStyle(
                  color: ColorManager.secondaryColor, fontSize: 16),
            ),
            value: widget.selectedCategoryList.contains(categoryList[index]),
            onChanged: (value) {
              if (value == null) return;
              if (value) {
                widget.selectedCategoryList.add(categoryList[index]);
              } else {
                widget.selectedCategoryList.remove(categoryList[index]);
              }
              setState(() {});
            }),
      ),
    );
  }
}
