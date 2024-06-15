import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/ai_recipe/ai_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/common_heading.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/loading_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

class AIRecipeResultPage extends StatefulWidget {
  const AIRecipeResultPage({super.key});

  @override
  _AIRecipeResultPageState createState() {
    return _AIRecipeResultPageState();
  }
}

class _AIRecipeResultPageState extends State<AIRecipeResultPage> {
  AIRecipeBloc aiRecipeBloc = GetIt.instance<AIRecipeBloc>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: const CustomAppBar(title: "AI Result Recipe"),
      body: BlocConsumer<AIRecipeBloc, AIRecipeState>(
        bloc: aiRecipeBloc,
        listener: (context, state) {
          if (state is AIRecipeErrorState) {
            showAnimatedDialog2(
                context, AppErrorDialog(content: state.failure.toString()));
          }
        },
        builder: (context, state) {
          if (state is AIRecipeLoadedState) {
            RecipeEntity recipeEntity = state.recipe;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeEntity.title,
                      style: getBoldStyle(
                          fontSize: 30, color: ColorManager.secondaryColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const CommonHeading(content: "${AppStrings.veg}: "),
                        Text(
                          recipeEntity.isVegan ? AppStrings.yes : AppStrings.no,
                          style: getSemiBoldStyle(
                              fontSize: 14,
                              color: recipeEntity.isVegan
                                  ? ColorManager.vegColor
                                  : ColorManager.nonVegColor),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const CommonHeading(content: "${AppStrings.serves}: "),
                        Text(recipeEntity.serves.toString())
                      ],
                    ),
                    Row(
                      children: [
                        const CommonHeading(
                            content: "${AppStrings.cookTime}: "),
                        Text("${recipeEntity.cookTime} ${AppStrings.minutes}")
                      ],
                    ),
                    const CommonHeading(content: AppStrings.description),
                    Text(recipeEntity.description),
                    const Divider(),
                    const CommonHeading(content: AppStrings.categories),
                    Text(recipeEntity.categories),
                    const CommonHeading(content: AppStrings.ingredients),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ...recipeEntity.ingredients.map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("- $e"),
                          ),
                        )
                      ],
                    ),
                    const CommonHeading(content: AppStrings.instructions),
                    Text(recipeEntity.instruction),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                            onPressed: () {},
                            child: const Text(AppStrings.save)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is AIRecipeLoadingState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoadingWidget(),
                Text(
                  AppStrings.wait30s,
                  style: getRegularStyle(color: ColorManager.greyColor)
                      .copyWith(fontStyle: FontStyle.italic),
                )
              ],
            );
          }
          return Center(child: Text(state.runtimeType.toString()));
        },
      ),
    );
  }
}
