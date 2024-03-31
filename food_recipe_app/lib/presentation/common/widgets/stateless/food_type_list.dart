import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class FoodTypeList extends StatelessWidget {
  const FoodTypeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
      height: AppSize.s30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red, width: 1)),
            child: const Text(
              'Healthy',
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
