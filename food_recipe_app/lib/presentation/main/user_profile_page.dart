import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';

import 'package:food_recipe_app/presentation/blocs/user_recipes/user_recipes_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_description.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_introduction.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_social_status.dart';

import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

import '../resources/font_manager.dart';
import '../resources/route_management.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() {
    return _UserProfilePageState();
  }
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ChefEntity currentUser;
  final UserRecipesBloc _userRecipesBloc = GetIt.instance<UserRecipesBloc>();

  @override
  void initState() {
    super.initState();
    currentUser = GetIt.instance<BackgroundDataManager>().convertToChefEntity();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.yourProfile,
              style: getBoldStyle(
                  color: ColorManager.secondaryColor, fontSize: FontSize.s20),
            ),
            UserIntroduction(
              entity: currentUser,
            ),
            UserDescription(
              entity: currentUser,
            ),
            UserSocialStatus(
              entity: currentUser,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.editProfileRoute);
                    },
                    child: const Text(AppStrings.editProfile)),
                FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: ColorManager.blueColor),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.listChefPageRoute);
                    },
                    child: const Text(AppStrings.seeAllFollowers)),
              ],
            ),
            const Divider(
              color: Colors.black26,
            ),
            BlocBuilder<UserRecipesBloc, UserRecipesState>(
              bloc: _userRecipesBloc,
              builder: (context, state) {
                if (state is UserRecipesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UserRecipesLoadedState) {
                  return SizedBox(
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.recipeList.length,
                        itemBuilder: (context, index) {
                          return RecipeItem(
                            isUser: true,
                            recipe: state.recipeList[index],
                          );
                        },
                      ));
                }
                if (state is UserRecipesErrorState) {
                  return Center(
                    child: Text(state.failure.toString()),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
