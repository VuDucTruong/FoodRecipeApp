import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/home_food_item.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class RecipeListByCategoy extends StatelessWidget {
  const RecipeListByCategoy({
    super.key,
    required this.recipesByCategoryBloc,
  });

  final RecipesByCategoryBloc recipesByCategoryBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipesByCategoryBloc, RecipesByCategoryState>(
      bloc: recipesByCategoryBloc,
      builder: (context, state) {
        if (state is RecipesByCategoryLoadedState) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.recipesByCategory.length,
              itemBuilder: (context, index) {
                RecipeEntity item = state.recipesByCategory[index];
                return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                    child: HomeFoodItem(
                      isVegan: item.isVegan,
                      imageUrl: item.attachmentUrls[item.representIndex],
                      width: 120,
                      height: 200,
                      title: item.title,
                      fontSize: 12,
                    ));
              },
            ),
          );
        }
        if (state is RecipesByCategoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RecipesByCategoryErrorState) {
          return ErrorText(failure: state.failure);
        }
        return Container();
      },
    );
  }
}
