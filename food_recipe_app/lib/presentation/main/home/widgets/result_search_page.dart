import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/no_item_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/list_chef_page/chef_item.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

class ResultSearchPage extends StatelessWidget {
  const ResultSearchPage(
      {super.key,
      required this.chefList,
      required this.recipeList,
      required this.search});
  final List<RecipeEntity> recipeList;
  final List<ChefEntity> chefList;
  final String search;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BackgroundUser backgroundUser =
        GetIt.instance<BackgroundDataManager>().getBackgroundUser();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("${AppStrings.searchResult} \"$search\""),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppStrings.recipes,
                        style: getSemiBoldStyle(fontSize: 18),
                      ),
                    ),
                    recipeList.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipeList.length + 1,
                            itemBuilder: (context, index) {
                              if (recipeList.length == index) {
                                return FilledButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          Routes.recipesByCategoryRoute,
                                          arguments: search);
                                    },
                                    child: const Text(AppStrings.seeAll));
                              }
                              RecipeEntity recipe = recipeList[index];
                              return RecipeItem(
                                  isUser: backgroundUser.recipeIds
                                      .contains(recipe.id),
                                  recipe: recipe);
                            },
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: NoItemWidget(),
                            ),
                          ),
                  ],
                ),
              ),
              Card(
                elevation: 4,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppStrings.chefs,
                        style: getSemiBoldStyle(fontSize: 18),
                      ),
                    ),
                    chefList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chefList.length + 1,
                            itemBuilder: (context, index) {
                              if (chefList.length == index) {
                                return FilledButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.listChefPageRoute,
                                          arguments: search);
                                    },
                                    child: const Text(AppStrings.seeAll));
                              }
                              ChefEntity chef = chefList[index];
                              return ChefItem(
                                  chefEntity: chef,
                                  isFollowed: backgroundUser.followingIds
                                      .contains(chef.id));
                            },
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: NoItemWidget(),
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
