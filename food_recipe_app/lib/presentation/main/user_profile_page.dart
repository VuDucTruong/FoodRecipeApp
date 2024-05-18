import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/presentation/blocs/chef_info/chef_info_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_description.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_introduction.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_social_status.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

import '../../app/functions.dart';
import '../common/widgets/stateless/dialogs/app_error_dialog.dart';
import '../common/widgets/stateless/loading_widget.dart';
import '../resources/font_manager.dart';
import '../resources/route_management.dart';
import '../resources/value_manament.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() {
    return _UserProfilePageState();
  }
}

class _UserProfilePageState extends State<UserProfilePage> {
  ChefInfoBloc chefInfoBloc = GetIt.instance<ChefInfoBloc>();

  @override
  void initState() {
    super.initState();
    //chefInfoBloc.add(LoadChefInfoById(id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.yourProfile,
          style: getBoldStyle(
              color: ColorManager.secondaryColor, fontSize: FontSize.s20),
        ),
        BlocConsumer<ChefInfoBloc, ChefInfoState>(
          bloc: chefInfoBloc,
          listener: (context, state) {
            if (state is ChefInfoErrorState) {
              showAnimatedDialog1(
                  context, AppErrorDialog(content: state.failure.message));
            }
            if (state is ChefInfoLoadedState) {
              chefInfoBloc.add(LoadChefRecipes(state.chefEntity!.recipeIds));
            }
          },
          buildWhen: (previous, current) => current is ChefProfileState,
          listenWhen: (previous, current) => current is ChefProfileState,
          builder: (context, state) {
            if (state is ChefInfoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ChefInfoLoadedState) {
              return Column(
                children: [
                  UserIntroduction(
                    entity: state.chefEntity!,
                  ),
                  UserDescription(
                    entity: state.chefEntity!,
                  ),
                  UserSocialStatus(
                    entity: state.chefEntity!,
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        BlocBuilder<ChefInfoBloc, ChefInfoState>(
          bloc: chefInfoBloc,
          buildWhen: (previous, current) => current is ChefRecipeState,
          builder: (context, state) {
            if (state is ChefRecipeLoadedState) {
              return SizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.recipeList.length,
                    itemBuilder: (context, index) {
                      return RecipeItem(
                        isUser: false,
                        recipe: state.recipeList[index],
                      );
                    },
                  ));
            }
            if (state is ChefRecipeErrorState) {
              return Center(
                child: Text(state.failure.toString()),
              );
            }
            return const Center(
              child: LoadingWidget(),
            );
          },
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
