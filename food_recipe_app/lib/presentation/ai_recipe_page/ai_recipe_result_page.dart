import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/ai_recipe/ai_recipe_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/common_heading.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/custom_app_bar.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
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
      appBar: CustomAppBar(title: AppStrings.aiResultRecipeTitle.tr()),
      body: BlocConsumer<AIRecipeBloc, AIRecipeState>(
        bloc: aiRecipeBloc,
        listener: (context, state) {
          if (state is AIRecipeErrorState) {
            showAnimatedDialog2(context,
                AppErrorDialog(content: AppStrings.somethingWentWrong.tr()));
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
                      maxLines: 3,
                      style: getBoldStyle(
                          fontSize: 30, color: ColorManager.secondaryColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        CommonHeading(content: "${AppStrings.veg.tr()}: "),
                        Text(
                          recipeEntity.isVegan
                              ? AppStrings.yes.tr()
                              : AppStrings.no.tr(),
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
                        CommonHeading(content: "${AppStrings.serves.tr()}: "),
                        Text(recipeEntity.serves.toString())
                      ],
                    ),
                    Row(
                      children: [
                        CommonHeading(content: "${AppStrings.cookTime.tr()}: "),
                        Text(
                            "${recipeEntity.cookTime} ${AppStrings.minutes.tr()}")
                      ],
                    ),
                    CommonHeading(content: AppStrings.description.tr()),
                    Text(recipeEntity.description),
                    const Divider(),
                    CommonHeading(content: AppStrings.categories.tr()),
                    Text(recipeEntity.categories),
                    CommonHeading(content: AppStrings.ingredients.tr()),
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
                    CommonHeading(content: AppStrings.instructions.tr()),
                    Text(recipeEntity.instruction),
                    /*Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                            onPressed: () {},
                            child: Text(AppStrings.save.tr())),
                      ),
                    )*/
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
                  AppStrings.wait30s.tr(),
                  style: getRegularStyle(color: ColorManager.greyColor)
                      .copyWith(fontStyle: FontStyle.italic),
                )
              ],
            );
          }
          if (state is AIRecipeErrorState) {
            return ErrorText(failure: state.failure);
          }
          return Center(child: Text(state.runtimeType.toString()));
        },
      ),
    );
  }
}
