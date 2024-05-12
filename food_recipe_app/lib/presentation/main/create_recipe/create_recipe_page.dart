import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/common/helper/create_recipe_object.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/default_heads.dart';
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
import 'package:get_it/get_it.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  MutableVariable<int> headsValue = MutableVariable(2);
  List<String> ingredients = ['10kg sugar', '200g beef'];
  List<MultipartFile> multipartFiles = [];
  MutableVariable<bool> isVeg = MutableVariable(false);
  TextEditingController dishController = TextEditingController();
  TextEditingController cookTimeController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List<String> selectedCategoryList = [];
  late CreateRecipeBloc createRecipeBloc;
  late String selectedType;

  late List<String> typeList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typeList = Constant.typeList;
    selectedType = typeList[0];
    createRecipeBloc = GetIt.instance<CreateRecipeBloc>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dishController.dispose();
    cookTimeController.dispose();
    instructionController.dispose();
    descriptionController.dispose();
    // createRecipeBloc.close();
  }

  void clearContent() {
    setState(() {
      isVeg.value = false;
      dishController.clear();
      cookTimeController.clear();
      instructionController.clear();
      descriptionController.clear();
      ingredients.clear();
      ingredients.addAll(['10kg sugar', '200g beef']);
      multipartFiles.clear();
      selectedCategoryList.clear();
      headsValue.value = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: BlocListener<CreateRecipeBloc, CreateRecipeState>(
        bloc: createRecipeBloc,
        listener: (context, state) {
          if (state is CreateRecipeSuccessState) {
            Navigator.pop(context);
            showAnimatedDialog2(
                context,
                CongratulationDialog(
                  content: AppStrings.createSuccess,
                ));
          }
          if (state is CreateRecipeLoadingState) {
            showAnimatedDialog2(context, const LoadingDialog());
          }
          if (state is CreateRecipeErrorState) {
            Navigator.pop(context);
            showAnimatedDialog2(context, NoConnectionDialog(reload: () {}));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
              SelectionFoodImage(
                isVeg: isVeg,
                fileList: multipartFiles,
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
                        AppStrings.ingredients,
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
                          showAnimatedDialog2(context,
                              AppErrorDialog(content: AppStrings.noImageError));
                          return;
                        }
                        if (formKey.currentState!.validate()) {
                          ingredients.removeWhere((element) => element.isEmpty);
                          CreateRecipeObject object = CreateRecipeObject(
                              dishController.text,
                              instructionController.text,
                              descriptionController.text,
                              selectedCategoryList.join(','),
                              headsValue.value,
                              multipartFiles,
                              0,
                              int.parse(cookTimeController.text),
                              ingredients,
                              true,
                              isVeg.value);
                          createRecipeBloc
                              .add(CreateRecipeButtonPressed(object));
                        }
                      },
                      child: const Text(AppStrings.create)),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: ColorManager.darkBlueColor),
                      onPressed: () async {
                        bool isAccept = await showAnimatedDialog2(
                            context,
                            AppAlertDialog(
                                content: AppStrings.deleteContent)) as bool;
                        if (isAccept) {
                          clearContent();
                        }
                      },
                      child: const Text(AppStrings.delete)),
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
          AppStrings.instructions,
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
          AppStrings.cookTime,
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
            decoration: inputDecoration(hint: AppStrings.inMinutes),
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
        decoration: inputDecoration(hint: AppStrings.nameDish),
      ),
    );
  }

  Widget _getDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.description,
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
            decoration: inputDecoration(hint: AppStrings.descriptionHint),
          ),
        ),
      ],
    );
  }
}
