import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/saved_recipes/saved_recipes_bloc.dart';
import 'package:food_recipe_app/presentation/common/helper/get_saved_recipes_object.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/food_type_options.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/no_item_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:get_it/get_it.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';
import '../resources/style_management.dart';

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
  @override
  void initState() {
    super.initState();
    savedRecipesBloc.add(SavedRecipesCategorySelected(GetSavedRecipesObject(
        categories: [selectedItem.value], searchTerm: '')));
    scrollController.addListener(() async {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (savedRecipesBloc.state.isLastPage) {
          return;
        }
        //await Future.delayed(Duration(seconds: 1));
        savedRecipesBloc.add(SavedRecipesConinueLoading(GetSavedRecipesObject(
            categories: [selectedItem.value],
            searchTerm: '',
            page: (recipeList.length ~/ 10) + 1)));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reload() {
    savedRecipesBloc.add(SavedRecipesCategorySelected(GetSavedRecipesObject(
        categories: [selectedItem.value], searchTerm: '')));
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
        child: Icon(Icons.plumbing),
        children: [
          SpeedDialChild(child: Icon(Icons.abc)),
          SpeedDialChild(child: Icon(Icons.abc)),
          SpeedDialChild(child: Icon(Icons.abc)),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
              child: Row(
                children: [
                  Text(
                    AppStrings.savedRecipes,
                    style: getBoldStyle(
                        color: ColorManager.secondaryColor,
                        fontSize: FontSize.s20),
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
                      context, NoConnectionDialog(reload: reload));
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
                          isUser: true,
                          recipe: recipeList[index],
                        ));
                      });
                  /*return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        print(recipeList);
                        return ListTile(
                          subtitle: SizedBox(
                            height: 200,
                          ),
                          title: Text('$index'),
                        );
                      });*/
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
