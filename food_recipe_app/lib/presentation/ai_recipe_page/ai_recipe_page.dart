import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/ai_recipe_page/widgets/ai_text_field.dart';
import 'package:food_recipe_app/presentation/ai_recipe_page/widgets/image_list_widget.dart';
import 'package:food_recipe_app/presentation/ai_recipe_page/widgets/language_list_view.dart';
import 'package:food_recipe_app/presentation/blocs/ai_recipe/ai_recipe_bloc.dart';

import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/utils/gemini_utils.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../common/widgets/stateless/dialogs/loading_dialog.dart';

class AIRecipePage extends StatefulWidget {
  const AIRecipePage({super.key});

  @override
  _AIRecipePageState createState() {
    return _AIRecipePageState();
  }
}

class _AIRecipePageState extends State<AIRecipePage> {
  AIRecipeBloc aiRecipeBloc = GetIt.instance<AIRecipeBloc>();
  late TextEditingController basicIngredientController,
      allergyController,
      cuisineController,
      additionalContextController;

  void resetPrompt() {
    userPrompt = PromptData.empty();
    basicIngredientController.clear();
    allergyController.clear();
    additionalContextController.clear();
    cuisineController.clear();
  }

  PromptData userPrompt = PromptData.empty();

  @override
  void initState() {
    basicIngredientController = TextEditingController();
    allergyController = TextEditingController();
    cuisineController = TextEditingController();
    additionalContextController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  MutableVariable<String> selectedLanguage =
      MutableVariable(Constant.languageList.first);
  double elementPadding = 4;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Generate AI Recipe",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  elementPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Images of ingredient",
                        style: getBoldStyle(fontSize: 20),
                      ),
                    ),
                    ImageListWidget(userPrompt: userPrompt)
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 0.6)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Information",
                      style: getSemiBoldStyle(
                          fontSize: 20, color: ColorManager.darkBlueColor),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AITextField(
                      title: "1. I also have these staple ingredients:",
                      helperText:
                          "Oil, butter, pepper, salt, sugar, milk, vinegar,...",
                      textEditingController: basicIngredientController,
                    ),
                    AITextField(
                      title: "2. I'm in the mood for:",
                      helperText:
                          "Italian, Vietnamese, Chinese, Greek, French,...",
                      textEditingController: cuisineController,
                    ),
                    AITextField(
                      title: "3. I have the following dietary restrictions:",
                      helperText:
                          "vegan, dairy free, wheat allergy, soy allergy, nut allergy,...",
                      textEditingController: allergyController,
                    ),
                    AITextField(
                      title: "4. Additional context:",
                      helperText: "Type what you want to make your dish...",
                      textEditingController: additionalContextController,
                    ),
                    Text(
                      "5. Language:",
                      maxLines: 3,
                      style: getMediumStyle(
                          fontSize: 16, color: ColorManager.secondaryColor),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    LanguageListView(selectedLanguage: selectedLanguage)
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                      onPressed: () {
                        userPrompt.selectedBasicIngredients =
                            basicIngredientController.text;
                        userPrompt.selectedDietaryRestrictions =
                            allergyController.text;
                        userPrompt.selectedCuisines = cuisineController.text;
                        userPrompt.language = selectedLanguage.value;
                        aiRecipeBloc.add(SubmitPrompt(
                            userPrompt, additionalContextController.text));
                        Navigator.pushNamed(
                            context, Routes.aiRecipeResultRoute);
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: ColorManager.vegColor),
                      child: const Text("Submit")),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          textStyle: getSemiBoldStyle(
                              color: ColorManager.darkBlueColor, fontSize: 14)),
                      onPressed: () {
                        setState(() {
                          resetPrompt();
                        });
                      },
                      child: const Text("Reset")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}