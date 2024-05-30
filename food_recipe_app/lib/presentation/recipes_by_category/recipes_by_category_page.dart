import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/get_recipes_by_category_object.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_by_category_usecase.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
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

class RecipesByCategoryPage extends StatefulWidget {
  const RecipesByCategoryPage({super.key});

  @override
  _RecipesByCategoryPageState createState() {
    return _RecipesByCategoryPageState();
  }
}

class _RecipesByCategoryPageState extends State<RecipesByCategoryPage> {
  RecipesByCategoryBloc recipesByCategoryBloc =
      GetIt.instance<RecipesByCategoryBloc>();
  MutableVariable<String> selectedItem = MutableVariable(Constant.typeList[0]);
  ScrollController scrollController = ScrollController();
  MutableVariable<int> pageIndex = MutableVariable(0);
  List<RecipeEntity> recipeList = [];
  @override
  void initState() {
    super.initState();
    recipesByCategoryBloc.add(CategorySelected(selectedItem.value));
    scrollController.addListener(() async {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (recipesByCategoryBloc.state.isLastPage) {
          return;
        }
        print(recipesByCategoryBloc.state.isLastPage);
        //await Future.delayed(Duration(seconds: 1));
        recipesByCategoryBloc.add(ConinueLoadingRecipes(
            GetRecipesByCategoryObject(
                categories: [selectedItem.value],
                page: (recipeList.length ~/ 2) + 1)));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reload() {
    recipesByCategoryBloc.add(CategorySelected(selectedItem.value));
  }

  void resetData() {
    recipeList.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    recipeList = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            PicturePath.backArrowPath,
          ),
        ),
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
                    AppStrings.recipesByCategory,
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
              bloc: recipesByCategoryBloc,
              resetData: resetData,
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            BlocConsumer<RecipesByCategoryBloc, RecipesByCategoryState>(
              bloc: recipesByCategoryBloc,
              listener: (context, state) {
                if (state is SavedRecipesErrorState) {
                  showAnimatedDialog2(
                      context, NoConnectionDialog(reload: reload));
                }
              },
              builder: (context, state) {
                if (state is RecipesByCategoryLoadedState) {
                  recipeList.addAll(state.recipesByCategory);
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
                          isUser: false,
                          recipe: recipeList[index],
                        ));
                      });
                }
                if (state is RecipesByCategoryLoadingState) {
                  return const LoadingWidget();
                }
                if (state is RecipesByCategoryErrorState) {
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
