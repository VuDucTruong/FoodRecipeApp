import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/utils/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/object/update_follow_object.dart';
import 'package:food_recipe_app/presentation/blocs/chef_info/chef_info_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateful/comon_follow_button.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/congratulation_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/recipe_item.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_description.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_introduction.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/user_social_status.dart';
import 'package:get_it/get_it.dart';

import '../resources/assets_management.dart';
import '../resources/color_management.dart';
import '../resources/font_manager.dart';
import '../resources/string_management.dart';
import '../resources/style_management.dart';
import '../resources/value_manament.dart';

class ChefProfileView extends StatefulWidget {
  const ChefProfileView({super.key, required this.chefId});

  final String chefId;

  @override
  _ChefProfileViewState createState() {
    return _ChefProfileViewState();
  }
}

class _ChefProfileViewState extends State<ChefProfileView> {
  ChefInfoBloc chefInfoBloc = GetIt.instance<ChefInfoBloc>();
  BackgroundUser backgroundUser =
      GetIt.instance<BackgroundDataManager>().getBackgroundUser();

  @override
  void initState() {
    super.initState();
    chefInfoBloc.add(LoadChefInfoById(widget.chefId));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.chefProfile,
          style: getBoldStyle(
              color: ColorManager.secondaryColor, fontSize: FontSize.s20),
        ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(AppMargin.m8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<ChefInfoBloc, ChefInfoState>(
                  bloc: chefInfoBloc,
                  listener: (context, state) {
                    if (state is ChefInfoErrorState) {
                      showAnimatedDialog1(context,
                          AppErrorDialog(content: state.failure.message));
                    }
                    if (state is ChefInfoLoadedState) {
                      chefInfoBloc
                          .add(LoadChefRecipes(state.chefEntity!.recipeIds));
                    }
                  },
                  buildWhen: (previous, current) => current is ChefProfileState,
                  listenWhen: (previous, current) =>
                      current is ChefProfileState,
                  builder: (context, state) {
                    if (state is ChefInfoLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ChefInfoLoadedState) {
                      bool isFollowed = backgroundUser.followingIds
                          .contains(state.chefEntity!.id);
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
                          CommonFollowButton(
                            onPressed: () {
                              chefInfoBloc.add(UpdateFollowChef(
                                  UpdateFollowObject(
                                      state.chefEntity!.id, isFollowed),
                                  state.chefEntity!));
                            },
                            chefEntity: state.chefEntity!,
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
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.recipeList.length,
                        itemBuilder: (context, index) {
                          return RecipeItem(
                            isUser: false,
                            recipe: state.recipeList[index],
                          );
                        },
                      );
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
            ),
          ),
        ),
      ),
    );
  }
}
