import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class IngredientListView extends StatefulWidget {
  const IngredientListView({super.key});
  @override
  _IngredientListViewState createState() {
    return _IngredientListViewState();
  }
}

class _IngredientListViewState extends State<IngredientListView> {
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
              child: _getIngredientItem(),
            );
          },
        ),
        const InkWell(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p4),
                child: Icon(
                  Icons.add,
                  size: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                AppStrings.addMoreIngredients,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getIngredientItem() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: SizedBox(
            height: 40,
            child: TextFormField(
              style: getSemiBoldStyle(color: Colors.black),
              decoration: inputDecoration(hint: AppStrings.item),
            ),
          ),
        ),
        const SizedBox(
          width: AppSize.s8,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 40,
            child: TextFormField(
                keyboardType: TextInputType.number,
                style: getSemiBoldStyle(color: Colors.black),
                decoration: inputDecoration(hint: AppStrings.quantity)),
          ),
        )
      ],
    );
  }

  InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.all(AppPadding.p12),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManager.secondaryColor, width: AppSize.s2),
          borderRadius: BorderRadius.circular(AppRadius.r10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: ColorManager.secondaryColor, width: AppSize.s2),
          borderRadius: BorderRadius.circular(AppRadius.r10)),
    );
  }
}
