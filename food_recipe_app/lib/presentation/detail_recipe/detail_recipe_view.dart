import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/data/background_data/background_data_manager.dart';
import 'package:food_recipe_app/domain/entity/background_user.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/chef_info/chef_info_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/detail_recipe/widgets/recipe_image.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

import '../resources/assets_management.dart';
import '../resources/font_manager.dart';
import '../resources/value_manament.dart';

class DetailRecipeView extends StatefulWidget {
  DetailRecipeView({super.key, required this.recipeEntity});
  RecipeEntity recipeEntity;
  @override
  _DetailRecipeViewState createState() {
    return _DetailRecipeViewState();
  }
}

class _DetailRecipeViewState extends State<DetailRecipeView> {
  final ChefInfoBloc chefInfoBloc = GetIt.instance<ChefInfoBloc>();
  BackgroundUser backgroundUser =
      GetIt.instance<BackgroundDataManager>().getBackgroundUser();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chefInfoBloc.add(LoadChefInfoById(widget.recipeEntity.userId));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
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
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  _getFoodTitle(width, widget.recipeEntity.title),
                ],
              ),
              const SizedBox(
                height: AppSize.s8,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getFoodImage(width),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    Text(AppStrings.ingredients,
                        style: getBoldStyle(
                            color: ColorManager.secondaryColor,
                            fontSize: FontSize.s20)),
                    Container(
                        margin:
                            const EdgeInsets.symmetric(vertical: AppMargin.m8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.recipeEntity.ingredients.length,
                          itemBuilder: (context, index) {
                            return RichText(
                                overflow: TextOverflow.clip,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: ' - ',
                                      style: getRegularStyle(
                                          fontSize: 16,
                                          color: ColorManager.secondaryColor)),
                                  TextSpan(
                                    text:
                                        widget.recipeEntity.ingredients[index],
                                    style: getSemiBoldStyle(
                                        color: Colors.black,
                                        fontSize: FontSize.s16),
                                  ),
                                ]));
                          },
                        )),
                    Text(AppStrings.instructions,
                        style: getBoldStyle(
                            color: ColorManager.secondaryColor,
                            fontSize: FontSize.s20)),
                    Container(
                        margin:
                            const EdgeInsets.symmetric(vertical: AppMargin.m8),
                        child: Text(
                          overflow: TextOverflow.clip,
                          widget.recipeEntity.instruction
                              .replaceAll(r'\n', '\n'),
                          style: getRegularStyle(
                              color: Colors.black, fontSize: FontSize.s16),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getFoodImage(double width) {
    return BlocConsumer<ChefInfoBloc, ChefInfoState>(
      bloc: chefInfoBloc,
      listener: (context, state) {
        if (state is ChefInfoErrorState) {
          showAnimatedDialog2(
              context, AppErrorDialog(content: state.failure.message));
        }
      },
      builder: (context, state) {
        if (state is ChefInfoLoadingState) {
          return const LoadingWidget();
        }
        if (state is ChefInfoLoadedState) {}
        return RecipeImage(
            recipeEntity: widget.recipeEntity, chefEntity: state.chefEntity);
      },
    );
  }

  Widget _getFoodTitle(double width, String foodName) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: width * 1.1,
          height: 40,
          decoration: const BoxDecoration(
            color: ColorManager.darkBlueColor,
          ),
          child: Center(
            child: Text(
              foodName,
              style: getBoldStyle(color: Colors.white, fontSize: FontSize.s20),
            ),
          ),
        ),
        Container(
          width: 28,
          height: 28,
          transform: Matrix4.translationValues(-14, 0, 0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.lightBG,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(AppRadius.r45),
              color: ColorManager.vegColor),
        ),
      ],
    );
  }
}
