import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/domain/object/search_object.dart';
import 'package:food_recipe_app/domain/object/user_search_object.dart';
import 'package:food_recipe_app/domain/usecase/get_recipes_by_category_usecase.dart';
import 'package:food_recipe_app/domain/usecase/get_search_chefs_usecase.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

// Hàm top-level để tìm kiếm recipes
Future<List<RecipeEntity>> getSearchRecipes(String search) async {
  GetRecipesByCategoryUseCase getRecipesByCategoryUseCase =
      GetIt.instance<GetRecipesByCategoryUseCase>();
  final result =
      await getRecipesByCategoryUseCase.execute(RecipeSearchObject([], search));
  return result.fold((l) => [], (r) => r);
}

// Hàm top-level để tìm kiếm chefs
Future<List<ChefEntity>> getSearchChefs(String search) async {
  GetSearchChefsUseCase getSearchChefsUseCase =
      GetIt.instance<GetSearchChefsUseCase>();
  final result = await getSearchChefsUseCase.execute(UserSearchObject(search));
  return result.fold((l) => [], (r) => r);
}

class HomeSearchDelegate extends SearchDelegate {
  List<ChefEntity> searchChefs = [];
  List<RecipeEntity> searchRecipes = [];
  bool _isLoading = false;
  Timer? _debounce;

  Future<void> _fetchSuggestions(String query) async {
    final results =
        await Future.wait([getSearchRecipes(query), getSearchChefs(query)]);
    searchRecipes = results[0].cast();
    searchChefs = results[1].cast();
  }

  void clearSuggestions() {
    searchRecipes.clear();
    searchChefs.clear();
  }

  void _onQueryChanged(String query, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        _fetchSuggestions(query).then((_) {
          _isLoading = false;
          showSuggestions(context);
        });
        _isLoading = true;
      } else {
        clearSuggestions();
        showSuggestions(context);
      }
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (_isLoading)
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        )
      else
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            clearSuggestions();
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    // TODO: implement showResults
    super.showResults(context);
    Navigator.pushNamed(context, Routes.resultSearchRoute,
        arguments: [searchChefs, searchRecipes, query]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query, context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: searchRecipes.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.recipes,
                style: getMediumStyle(fontSize: 16),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchRecipes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchRecipes[index].title),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.detailFoodRoute,
                      arguments: searchRecipes[index]);
                },
              );
            },
          ),
          Visibility(
            visible: searchChefs.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.chefs,
                style: getMediumStyle(fontSize: 16),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchChefs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchChefs[index].profileInfo.fullName),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.chefProfileRoute,
                      arguments: searchChefs[index].id);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: searchRecipes.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.recipes,
                style: getMediumStyle(fontSize: 16),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchRecipes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchRecipes[index].title),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.detailFoodRoute,
                      arguments: searchRecipes[index]);
                },
              );
            },
          ),
          Visibility(
            visible: searchChefs.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.chefs,
                style: getMediumStyle(fontSize: 16),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchChefs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchChefs[index].profileInfo.fullName),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.chefProfileRoute,
                      arguments: searchChefs[index].id);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
