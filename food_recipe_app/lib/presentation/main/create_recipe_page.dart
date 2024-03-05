import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';

import '../resources/assets_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';
import '../resources/value_manament.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  int value = 2;
  bool isVeg = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                  child: Text(
                    AppStrings.createRecipe,
                    style: getBoldStyle(
                        color: ColorManager.secondaryColor,
                        fontSize: FontSize.s20),
                  )),
              _getFoodImage(),
              _getDishName(),
              _getServes(),
              const SizedBox(
                height: AppSize.s12,
              ),
              _getCookTime(),
              Text(
                AppStrings.ingredients,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s20),
              ),
              _getIngredientList(),
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
              ),
              Text(
                AppStrings.instructions,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s20),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              _getInstructionsInput()
            ],
          ),
        ),
      ),
    );
  }

  ListView _getIngredientList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: value,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
          child: _getIngredientItem(),
        );
      },
    );
  }

  TextFormField _getInstructionsInput() {
    return TextFormField(
      maxLines: null,
      minLines: 5,
      style: getSemiBoldStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(AppPadding.p12),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.secondaryColor, width: AppSize.s2),
            borderRadius: BorderRadius.circular(AppRadius.r10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.secondaryColor, width: AppSize.s2),
            borderRadius: BorderRadius.circular(AppRadius.r10)),
      ),
    );
  }

  Row _getCookTime() {
    return Row(
      children: [
        SvgPicture.asset(PicturePath.timerPath),
        const SizedBox(
          width: AppSize.s12,
        ),
        Text(
          AppStrings.cookTime,
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
        ),
        const Spacer(),
        SizedBox(
          width: AppSize.s100,
          height: AppSize.s30,
          child: Form(
            child: TextFormField(
              textAlign: TextAlign.center,
              style: getSemiBoldStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: AppStrings.inMinutes,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r10),
                  borderSide: BorderSide(
                      color: ColorManager.secondaryColor, width: AppSize.s1_5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r10),
                  borderSide: BorderSide(
                      color: ColorManager.secondaryColor, width: AppSize.s1_5),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Container _getServes() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
      child: Row(
        children: [
          SvgPicture.asset(PicturePath.peoplePath),
          const SizedBox(
            width: AppSize.s12,
          ),
          Text(
            AppStrings.serves,
            style: getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
          ),
          const Spacer(),
          Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.r15),
                      color: Colors.grey.shade300),
                  width: AppSize.s120,
                  height: AppSize.s30,
                  child: Center(
                    child: Text(
                      '2',
                      style: getBoldStyle(
                          color: Colors.black, fontSize: FontSize.s17),
                    ),
                  )),
              Positioned(
                left: 0,
                child: Container(
                  width: AppSize.s30,
                  height: AppSize.s30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: ColorManager.linearGradientPink),
                  child: Center(
                    child: IconButton(
                        iconSize: AppSize.s16,
                        onPressed: () {},
                        icon: const Icon(Icons.remove)),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: AppSize.s30,
                  height: AppSize.s30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.r10),
                      gradient: ColorManager.linearGradientDarkBlue),
                  child: Center(
                    child: IconButton(
                        iconSize: AppSize.s16,
                        onPressed: () {},
                        icon: const Icon(Icons.add)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _getDishName() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: TextFormField(
        style: getSemiBoldStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r10),
              borderSide: BorderSide(
                  color: ColorManager.secondaryColor, width: AppSize.s1_5)),
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r10),
              borderSide: BorderSide(
                  color: ColorManager.secondaryColor, width: AppSize.s1_5)),
          hintText: AppStrings.nameDish,
        ),
      ),
    );
  }

  Stack _getFoodImage() {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: AppSize.s150,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(AppRadius.r20),
            border: Border.all(
                color: ColorManager.secondaryColor, width: AppSize.s2)),
        child: SvgPicture.asset(
          PicturePath.emptyRecipePath,
          fit: BoxFit.fill,
        ),
      ),
      Positioned(
        bottom: 5,
        left: 10,
        child: InkWell(
          child: CircleAvatar(
            radius: AppRadius.r15,
            backgroundColor:
                isVeg ? ColorManager.vegColor : ColorManager.nonVegColor,
          ),
          onTap: () {
            setState(() {
              isVeg = !isVeg;
            });
          },
        ),
      )
    ]);
  }

  Widget _getIngredientItem() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: SizedBox(
            height: AppSize.s30,
            child: TextFormField(
              style: getSemiBoldStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(AppPadding.p8),
                hintText: AppStrings.item,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    borderSide: BorderSide(
                        color: ColorManager.secondaryColor,
                        width: AppSize.s1_5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    borderSide: BorderSide(
                        color: ColorManager.secondaryColor,
                        width: AppSize.s1_5)),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: AppSize.s8,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: AppSize.s30,
            child: TextFormField(
              keyboardType: TextInputType.number,
              style: getSemiBoldStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(AppPadding.p8),
                hintText: AppStrings.quantity,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    borderSide: BorderSide(
                        color: ColorManager.secondaryColor,
                        width: AppSize.s1_5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    borderSide: BorderSide(
                        color: ColorManager.secondaryColor,
                        width: AppSize.s1_5)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
