import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class IngredientListView extends StatefulWidget {
  IngredientListView({super.key, required this.ingredients});
  List<String> ingredients;
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
          itemCount: widget.ingredients.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
              child: _getIngredientItem(index),
            );
          },
        ),
        InkWell(
          onTap: () {
            setState(() {
              widget.ingredients.add('');
            });
          },
          child: const Row(
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

  Widget _getIngredientItem(int index) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: SizedBox(
            height: 40,
            child: TextFormField(
              initialValue: widget.ingredients[index],
              style: getSemiBoldStyle(color: Colors.black),
              decoration: inputDecoration(hint: AppStrings.item),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                widget.ingredients.removeAt(index);
              });
            },
            icon: const Icon(Icons.remove_circle))
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
