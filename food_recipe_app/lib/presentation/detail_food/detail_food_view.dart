import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/chef_info/chef_info_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/app_error_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/detail_food/widgets/chef_background.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:get_it/get_it.dart';

import '../resources/assets_management.dart';
import '../resources/font_manager.dart';
import '../resources/value_manament.dart';

class DetailFoodView extends StatefulWidget {
  DetailFoodView({super.key, required this.recipeEntity});
  RecipeEntity recipeEntity;
  @override
  _DetailFoodViewState createState() {
    return _DetailFoodViewState();
  }
}

class _DetailFoodViewState extends State<DetailFoodView> {
  ChefInfoBloc chefInfoBloc = GetIt.instance<ChefInfoBloc>();

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
        return Stack(
          children: [
            const SizedBox(
              height: 220 + 40,
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: AppSize.s220,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurStyle: BlurStyle.outer,
                      offset: Offset(-1, 0),
                      blurRadius: 0.5,
                    )
                  ],
                  image: DecorationImage(
                      image: NetworkImage(widget.recipeEntity
                          .attachmentUrls[widget.recipeEntity.representIndex])),
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(20)),
                  color: Colors.white),
            ),
            Positioned(
                right: 0,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorManager.pinkColor.withOpacity(0.6),
                      ),
                      height: AppSize.s220,
                      width: width / 2.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: ColorManager.lightBG.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: state.chefEntity != null
                                      ? NetworkImage(state.chefEntity
                                              ?.profileInfo.avatarUrl ??
                                          '')
                                      : const AssetImage(
                                              PicturePath.errorImagePath)
                                          as ImageProvider,
                                  onError: (exception, stackTrace) =>
                                      const AssetImage(
                                          PicturePath.errorImagePath),
                                )),
                          ),
                          Text(
                            state.chefEntity?.profileInfo.fullName ??
                                AppStrings.notFound,
                            style: getRegularStyle(
                                color: ColorManager.darkBlueColor,
                                fontSize: FontSize.s15),
                          ),
                          const SizedBox(
                            height: AppSize.s15,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              SvgPicture.asset(
                                PicturePath.timerPath,
                                width: AppSize.s15,
                                height: AppSize.s15,
                                colorFilter: const ColorFilter.mode(
                                    ColorManager.darkBlueColor,
                                    BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              Text(
                                '${widget.recipeEntity.cookTime} ${AppStrings.minutes}',
                                style: getBoldStyle(
                                    color: ColorManager.darkBlueColor,
                                    fontSize: FontSize.s14),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              SvgPicture.asset(
                                PicturePath.peoplePath,
                                width: AppSize.s15,
                                height: AppSize.s15,
                                colorFilter: const ColorFilter.mode(
                                    ColorManager.darkBlueColor,
                                    BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              Text(
                                '${widget.recipeEntity.serves} ${AppStrings.people}',
                                style: getBoldStyle(
                                    color: ColorManager.darkBlueColor,
                                    fontSize: FontSize.s14),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              SvgPicture.asset(
                                PicturePath.likedPath,
                                width: AppSize.s15,
                                height: AppSize.s15,
                                colorFilter: const ColorFilter.mode(
                                    ColorManager.darkBlueColor,
                                    BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              Text(
                                '${widget.recipeEntity.likes}',
                                style: getBoldStyle(
                                    color: ColorManager.darkBlueColor,
                                    fontSize: FontSize.s14),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    ChefBackground(
                      recipeId: widget.recipeEntity.id,
                    )
                  ],
                )),
          ],
        );
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
