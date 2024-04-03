import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/default_heads.dart';
import 'package:food_recipe_app/presentation/main/create_recipe/widgets/ingredient_list_view.dart';
import 'package:food_recipe_app/presentation/main/create_recipe/widgets/selection_food_image.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  MutableVariable<int> headsValue = MutableVariable(2);
  MutableVariable<bool> isVeg = MutableVariable(false);
  TextEditingController dishController = TextEditingController();
  TextEditingController cookTimeController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  late String selectedType;

  List<String> typeList = [
    "Healthy",
    "Fast Food",
    "Quick",
    "Cuisine",
    "Breakfast",
    "Snack",
    "Lunch",
    "Dinner",
    "Dessert",
    "Soup",
    "Drink",
    "Traditional"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedType = typeList[0];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dishController.dispose();
    cookTimeController.dispose();
    itemController.dispose();
    quantityController.dispose();
    instructionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
              child: Text(
                AppStrings.createRecipe,
                style: getBoldStyle(
                    color: ColorManager.secondaryColor, fontSize: FontSize.s20),
              )),
          SelectionFoodImage(
            isVeg: isVeg,
          ),
          _getDishName(),
          _getServes(),
          const SizedBox(
            height: AppSize.s12,
          ),
          _getCookTime(),
          const SizedBox(
            height: 8,
          ),
          _getFoodType(),
          Text(
            AppStrings.ingredients,
            style: getBoldStyle(
                color: ColorManager.secondaryColor, fontSize: FontSize.s20),
          ),
          const IngredientListView(),
          _getInstructionsInput(),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                  onPressed: () {}, child: const Text(AppStrings.create)),
              FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: ColorManager.darkBlueColor),
                  onPressed: () {},
                  child: const Text(AppStrings.delete)),
            ],
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
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

  Widget _getInstructionsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.instructions,
          style: getBoldStyle(
              color: ColorManager.secondaryColor, fontSize: FontSize.s20),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        TextFormField(
          controller: instructionController,
          maxLines: null,
          minLines: 5,
          style: getSemiBoldStyle(color: Colors.black),
          decoration: inputDecoration(),
        ),
      ],
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
          height: 40,
          child: TextFormField(
            controller: cookTimeController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: getSemiBoldStyle(color: Colors.black),
            decoration: inputDecoration(hint: AppStrings.inMinutes),
          ),
        )
      ],
    );
  }

  Row _getFoodType() {
    return Row(
      children: [
        SvgPicture.asset(PicturePath.timerPath),
        const SizedBox(
          width: AppSize.s12,
        ),
        Text(
          AppStrings.foodCategory,
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
            child: DropdownButtonFormField<String>(
          decoration: inputDecoration(hint: AppStrings.selectFoodType),
          value: selectedType,
          items: [
            ...typeList.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
          ],
          onChanged: (value) {
            if (value == null || value.isEmpty) return;
            selectedType = value;
          },
        ))
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
          DefaultHeads(headNumber: headsValue),
        ],
      ),
    );
  }

  Container _getDishName() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
      child: TextFormField(
        controller: dishController,
        style: getSemiBoldStyle(color: Colors.black),
        decoration: inputDecoration(hint: AppStrings.nameDish),
      ),
    );
  }
}
