import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/domain/entity/recipe_entity.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/trending_recipes/trending_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/food_type_options.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/chef_list.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/home_carousel_slider.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/home_food_item.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/recipe_list_by_category.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late TrendingBloc trendingBloc;
  late RecipesByCategoryBloc recipesByCategoryBloc;
  late VerifiedChefsBloc verifiedChefsBloc;
  late MutableVariable<String> selectedCateogry;

  @override
  void initState() {
    super.initState();
    selectedCateogry = MutableVariable(Constant.typeList[0]);
    trendingBloc = GetIt.instance<TrendingBloc>();
    verifiedChefsBloc = GetIt.instance<VerifiedChefsBloc>();
    verifiedChefsBloc.add(VerifiedChefsLoad());
    recipesByCategoryBloc = GetIt.instance<RecipesByCategoryBloc>();
    trendingBloc.add(TrendingLoad());
    recipesByCategoryBloc.add(CategorySelected(selectedCateogry.value));
  }

  void reloadPage() {
    verifiedChefsBloc.add(VerifiedChefsLoad());
    trendingBloc.add(TrendingLoad());
    recipesByCategoryBloc.add(CategorySelected(selectedCateogry.value));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: RefreshIndicator(
        backgroundColor: ColorManager.secondaryColor,
        color: ColorManager.primaryColor,
        onRefresh: () => Future.delayed(Duration.zero, reloadPage),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getSlogan(),
                _getSearchBar(),
                const SizedBox(
                  height: AppSize.s20,
                ),
                _getHeadingHome(AppStrings.trendingToday),
                HomeCarouselSlider(
                  bloc: trendingBloc,
                  reload: reloadPage,
                ),
                _getHeadingHome(AppStrings.categories),
                FoodTypeOptions(
                  selectedItem: selectedCateogry,
                  bloc: recipesByCategoryBloc,
                ),
                RecipeListByCategoy(
                    recipesByCategoryBloc: recipesByCategoryBloc),
                _getHeadingHome(AppStrings.verifiedChefs),
                ChefList(verifiedChefsBloc: verifiedChefsBloc),
                const SizedBox(
                  height: AppSize.s8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _getSlogan() {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m4, bottom: AppMargin.m8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.homeTitle,
            style: getBoldStyle(
                color: ColorManager.secondaryColor, fontSize: FontSize.s20),
          ),
          SvgPicture.asset(
            PicturePath.logoSVGPath,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }

  Widget _getHeadingHome(String content) {
    return Row(
      children: [
        Text(
          content,
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s18),
        ),
        const Spacer(),
        Text(
          AppStrings.seeAll,
          style: getRegularStyleWithUnderline(
              color: Colors.grey, fontSize: FontSize.s15),
        ),
      ],
    );
  }

  Widget _getSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m4),
      child: Material(
          elevation: 8,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(AppRadius.r15),
          child: Form(
            child: TextFormField(
                decoration: InputDecoration(
              suffixIcon: SvgPicture.asset(
                PicturePath.searchPath,
                fit: BoxFit.none,
              ),
            )),
          )),
    );
  }
}
