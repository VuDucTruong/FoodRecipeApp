import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class FoodTypeOptions extends StatefulWidget {
  FoodTypeOptions({Key? key, required this.selectedItem, required this.bloc})
      : super(key: key);
  MutableVariable<String> selectedItem;
  RecipesByCategoryBloc bloc;
  @override
  State<FoodTypeOptions> createState() => _FoodTypeOptionsState();
}

class _FoodTypeOptionsState extends State<FoodTypeOptions> {
  List<String> typeList = Constant.typeList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.selectedItem = MutableVariable<String>(typeList[0]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
          height: AppSize.s30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: typeList.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    widget.bloc.add(CategorySelected(typeList[index]));
                    widget.selectedItem.value = typeList[index];
                  });
                },
                child: AnimatedContainer(
                  duration: Durations.medium1,
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: widget.selectedItem.value == typeList[index]
                          ? ColorManager.linearGradientSecondary
                          : const LinearGradient(
                              colors: [Colors.white, Colors.white]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red, width: 1)),
                  child: Text(typeList[index],
                      style: getMediumStyle(
                          color: widget.selectedItem.value == typeList[index]
                              ? Colors.white
                              : Colors.red)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
