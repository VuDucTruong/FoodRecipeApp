import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/app/di.dart';
import 'package:food_recipe_app/domain/object/search_object.dart';
import 'package:food_recipe_app/domain/object/user_search_object.dart';
import 'package:food_recipe_app/presentation/blocs/recipes_by_category/recipes_by_category_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/trending_recipes/trending_bloc.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/food_type_options.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/chef_list.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/home_carousel_slider.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/home_search_delegate.dart';
import 'package:food_recipe_app/presentation/main/home/widgets/recipe_list_by_category.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/color_management.dart';
import 'package:food_recipe_app/presentation/resources/font_manager.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/string_management.dart';
import 'package:food_recipe_app/presentation/resources/style_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';
import 'package:food_recipe_app/presentation/utils/mutable_variable.dart';
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
  late MutableVariable<String> selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = MutableVariable(Constant.typeList[0]);
    trendingBloc = GetIt.instance<TrendingBloc>();
    verifiedChefsBloc = GetIt.instance<VerifiedChefsBloc>();
    verifiedChefsBloc.add(SearchChefs(UserSearchObject('')));
    recipesByCategoryBloc = GetIt.instance<RecipesByCategoryBloc>();
    trendingBloc.add(TrendingLoad());
    recipesByCategoryBloc.add(CategorySelected(RecipeSearchObject(
      [selectedCategory.value],
      '',
    )));
  }

  void reloadPage() {
    verifiedChefsBloc.add(SearchChefs(UserSearchObject('')));
    trendingBloc.add(TrendingLoad());
    recipesByCategoryBloc.add(CategorySelected(RecipeSearchObject(
      [selectedCategory.value],
      '',
    )));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          initAIRecipeModule();
          Navigator.pushNamed(context, Routes.aiRecipeRoute);
        },
        child: SvgPicture.asset(
          PicturePath.iconAIPath,
          width: 32,
          height: 32,
          colorFilter: const ColorFilter.mode(
              ColorManager.darkBlueColor, BlendMode.srcIn),
        ),
      ),
      body: SafeArea(
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
                  _getHeadingHome(AppStrings.trendingToday.tr(), false, null),
                  HomeCarouselSlider(
                    bloc: trendingBloc,
                    reload: reloadPage,
                  ),
                  _getHeadingHome(AppStrings.categories.tr(), true, () {
                    Navigator.pushNamed(context, Routes.recipesByCategoryRoute);
                  }),
                  FoodTypeOptions(
                    selectedItem: selectedCategory,
                    bloc: recipesByCategoryBloc,
                  ),
                  RecipeListByCategoy(
                      recipesByCategoryBloc: recipesByCategoryBloc),
                  _getHeadingHome(AppStrings.verifiedChefs.tr(), true, () {
                    Navigator.pushNamed(context, Routes.listChefPageRoute);
                  }),
                  ChefList(verifiedChefsBloc: verifiedChefsBloc),
                  const SizedBox(
                    height: AppSize.s8,
                  )
                ],
              ),
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
          Expanded(
            child: Text(
              AppStrings.homeTitle.tr(),
              maxLines: 2,
              style: getBoldStyle(
                  color: ColorManager.secondaryColor, fontSize: FontSize.s20),
            ),
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

  Widget _getHeadingHome(String content, bool isSeeAll, Function? action) {
    return Row(
      children: [
        Text(
          content,
          style: getBoldStyle(color: Colors.black, fontSize: FontSize.s18),
        ).tr(),
        const Spacer(),
        isSeeAll
            ? InkWell(
                onTap: () {
                  action?.call();
                },
                child: Text(
                  AppStrings.seeAll.tr(),
                  style: getRegularStyleWithUnderline(
                      color: Colors.grey, fontSize: FontSize.s15),
                ),
              )
            : Container(),
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
                onTap: () {
                  showSearch(context: context, delegate: HomeSearchDelegate());
                },
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
