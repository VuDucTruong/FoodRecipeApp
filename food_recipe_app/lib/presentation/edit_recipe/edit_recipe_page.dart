import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:food_recipe_app/domain/object/create_recipe_object.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/default_heads.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_alert_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/main/create_recipe/widgets/category_list_view.dart';
import 'package:food_recipe_app/presentation/main/create_recipe/widgets/ingredient_list_view.dart';
import 'package:food_recipe_app/presentation/main/create_recipe/widgets/recipe_category_section.dart';
import 'package:food_recipe_app/presentation/main/create_recipe/widgets/selection_food_image.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:get_it/get_it.dart';

class EditRecipePage extends StatefulWidget {
  const EditRecipePage({super.key, required this.recipeEntity});
  final RecipeEntity recipeEntity;
  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  TextEditingController dishController = TextEditingController();
  TextEditingController cookTimeController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List<String> ingredients = [];
  List<MultipartFile> multipartFiles = [];
  List<String> selectedCategoryList = [];
  late RecipeEntity recipeEntity;
  late MutableVariable<int> headsValue;
  late MutableVariable<bool> isVeg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipeEntity = widget.recipeEntity;
    initRecipe();
  }

  void initRecipe() {
    ingredients = recipeEntity.ingredients;
    selectedCategoryList = recipeEntity.categories.split(',');
    headsValue = MutableVariable(recipeEntity.serves);
    isVeg = MutableVariable(recipeEntity.isVegan);
    dishController.text = recipeEntity.title;
    cookTimeController.text = recipeEntity.cookTime.toString();
    instructionController.text =
        recipeEntity.instruction.replaceAll(r'\n', '\n');
    descriptionController.text = recipeEntity.description;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dishController.dispose();
    cookTimeController.dispose();
    instructionController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.editRecipe.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                  child: Text(
                    AppStrings.createRecipe.tr(),
                    style: getBoldStyle(
                        color: ColorManager.secondaryColor,
                        fontSize: FontSize.s20),
                  )),
              SelectionFoodImage(
                isVeg: isVeg,
                fileList: multipartFiles,
                url: recipeEntity.attachmentUrls[recipeEntity.representIndex],
              ),
              Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getDishName(),
                      _getDescription(),
                      _getServes(),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      _getCookTime(),
                      const SizedBox(
                        height: 8,
                      ),
                      RecipeCategorySection(
                          selectedCategoryList: selectedCategoryList),
                      Text(
                        AppStrings.ingredients.tr(),
                        style: getBoldStyle(
                            color: ColorManager.secondaryColor,
                            fontSize: FontSize.s20),
                      ),
                      IngredientListView(
                        ingredients: ingredients,
                      ),
                      _getInstructionsInput(),
                    ],
                  )),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                      onPressed: () async {
                        if (multipartFiles.isEmpty) {
                          showAnimatedDialog2(
                              context,
                              AppErrorDialog(
                                  content: AppStrings.noImageError.tr()));
                          return;
                        }
                        if (formKey.currentState!.validate()) {
                          ingredients.removeWhere((element) => element.isEmpty);
                          // Excute
                        }
                      },
                      child: Text(AppStrings.save.tr())),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: ColorManager.darkBlueColor),
                      onPressed: () async {
                        bool isAccept = await showAnimatedDialog2(
                                context,
                                AppAlertDialog(
                                    content: AppStrings.deleteContent.tr()))
                            as bool;
                        if (isAccept) {
                          // execute delete function and navigate
                        }
                      },
                      child: Text(AppStrings.delete.tr())),
                ],
              ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      errorStyle: const TextStyle(
        fontSize: 12,
        color: ColorManager.blueColor,
      ),
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
          AppStrings.instructions.tr(),
          style: getBoldStyle(
              color: ColorManager.secondaryColor, fontSize: FontSize.s20),
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validateEmpty,
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
          AppStrings.cookTime.tr(),
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
        ),
        const Spacer(),
        SizedBox(
          width: 130,
          height: 60,
          child: TextFormField(
            validator: validateEmpty,
            controller: cookTimeController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: getSemiBoldStyle(color: Colors.black),
            decoration: inputDecoration(hint: AppStrings.inMinutes.tr()),
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
            AppStrings.serves.tr(),
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
        validator: validateEmpty,
        controller: dishController,
        style: getSemiBoldStyle(color: Colors.black),
        decoration: inputDecoration(hint: AppStrings.nameDish.tr()),
      ),
    );
  }

  Widget _getDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.description.tr(),
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s17),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
          child: TextFormField(
            validator: validateEmpty,
            maxLines: null,
            minLines: 2,
            controller: descriptionController,
            style: getSemiBoldStyle(color: Colors.black),
            decoration: inputDecoration(hint: AppStrings.descriptionHint.tr()),
          ),
        ),
      ],
    );
  }
}
