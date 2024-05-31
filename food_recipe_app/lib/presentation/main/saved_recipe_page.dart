import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/get_saved_recipes_object.dart';
import 'package:food_recipe_app/domain/object/search_object.dart';
import 'package:food_recipe_app/presentation/blocs/saved_recipes/saved_recipes_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/food_type_options.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/no_item_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
import 'package:get_it/get_it.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';
import '../resources/style_management.dart';

enum RecipeView { SavedRecipes, MyRecipes }

class SavedRecipePage extends StatefulWidget {
  const SavedRecipePage({super.key});

  @override
  _SavedRecipePageState createState() {
    return _SavedRecipePageState();
  }
}

class _SavedRecipePageState extends State<SavedRecipePage> {
  SavedRecipesBloc savedRecipesBloc = GetIt.instance<SavedRecipesBloc>();
  MutableVariable<String> selectedItem = MutableVariable(Constant.typeList[0]);
  ScrollController scrollController = ScrollController();
  MutableVariable<int> pageIndex = MutableVariable(0);
  List<RecipeEntity> recipeList = [];
  RecipeView _recipeView = RecipeView.SavedRecipes;
  BackgroundUser backgroundUser =
      GetIt.instance<BackgroundDataManager>().getBackgroundUser();
  @override
  void initState() {
    super.initState();
    savedRecipesBloc.add(SavedRecipesCategorySelected(
        RecipeSearchObject([selectedItem.value], '')));

    scrollController.addListener(() async {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (savedRecipesBloc.state.isLastPage) {
          return;
        }
        //await Future.delayed(Duration(seconds: 1));
        if (_recipeView == RecipeView.SavedRecipes) {
          savedRecipesBloc.add(SavedRecipesConinueLoading(RecipeSearchObject(
              [selectedItem.value], '',
              page: (recipeList.length ~/ 10) + 1)));
        } else {
          savedRecipesBloc.add(MyRecipesContinueLoading(RecipeSearchObject(
              [selectedItem.value], '',
              page: (recipeList.length ~/ 10) + 1)));
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reloadSavedRecipes() {
    resetData();
    savedRecipesBloc.add(SavedRecipesCategorySelected(
        RecipeSearchObject([selectedItem.value], '')));
  }

  void reloadMyRecipes() {
    resetData();
    savedRecipesBloc.add(
        LoadMyRecipes(object: RecipeSearchObject([selectedItem.value], '')));
  }

  void resetData() {
    recipeList.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    recipeList = [];
    return Scaffold(
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
              child: const Icon(Icons.save),
              label: "Saved Recipes",
              onTap: () {
                _recipeView = RecipeView.SavedRecipes;
                reloadSavedRecipes();
              }),
          SpeedDialChild(
              child: const Icon(Icons.fastfood_rounded),
              label: "My Recipes",
              onTap: () {
                _recipeView = RecipeView.MyRecipes;
                reloadMyRecipes();
              }),
        ],
        child: const Icon(Icons.change_circle),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
              child: Row(
                children: [
                  BlocBuilder<SavedRecipesBloc, SavedRecipesState>(
                    bloc: savedRecipesBloc,
                    builder: (context, state) {
                      if (state is SavedRecipesLoadedState) {
                        return Text(
                          _recipeView == RecipeView.SavedRecipes
                              ? AppStrings.savedRecipes
                              : AppStrings.myRecipes,
                          style: getBoldStyle(
                              color: ColorManager.secondaryColor,
                              fontSize: FontSize.s20),
                        );
                      }
                      return Text(
                        AppStrings.savedRecipes,
                        style: getBoldStyle(
                            color: ColorManager.secondaryColor,
                            fontSize: FontSize.s20),
                      );
                    },
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    PicturePath.logoSVGPath,
                    width: AppSize.s50,
                    height: AppSize.s50,
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            FoodTypeOptions(
              selectedItem: selectedItem,
              bloc: savedRecipesBloc,
              resetData: resetData,
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            BlocConsumer<SavedRecipesBloc, SavedRecipesState>(
              bloc: savedRecipesBloc,
              listener: (context, state) {
                if (state is SavedRecipesErrorState) {
                  showAnimatedDialog2(
                      context,
                      NoConnectionDialog(
                          reload: _recipeView == RecipeView.SavedRecipes
                              ? reloadSavedRecipes
                              : reloadMyRecipes));
                }
              },
              builder: (context, state) {
                if (state is SavedRecipesLoadedState) {
                  recipeList.addAll(state.savedRecipeList);
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipeList.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index >= recipeList.length) {
                          if (state.isLastPage) {
                            return const NoItemWidget();
                          } else {
                            return const LoadingWidget();
                          }
                        }
                        return Center(
                            child: RecipeItem(
                          isUser: _recipeView == RecipeView.MyRecipes,
                          recipe: recipeList[index],
                        ));
                      });
                }
                if (state is SavedRecipesDeteledState) {
                  recipeList.remove(state.deletedRecipe);
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipeList.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index >= recipeList.length) {
                          if (state.isLastPage) {
                            return const NoItemWidget();
                          } else {
                            return const LoadingWidget();
                          }
                        }
                        return Center(
                            child: RecipeItem(
                          isUser: _recipeView == RecipeView.MyRecipes,
                          recipe: recipeList[index],
                        ));
                      });
                }
                if (state is SavedRecipesLoadingState) {
                  return const LoadingWidget();
                }
                if (state is SavedRecipesErrorState) {
                  return ErrorText(failure: state.failure);
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
