import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/app/functions.dart';
import 'package:food_recipe_app/presentation/blocs/trending_recipes/trending_bloc.dart';
import 'package:food_recipe_app/presentation/common/helper/mutable_variable.dart';

import 'package:food_recipe_app/presentation/common/widgets/stateless/common_food_title.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/dialogs/no_connection_dialog.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

import '../../../resources/route_management.dart';

class HomeCarouselSlider extends StatelessWidget {
  HomeCarouselSlider({super.key, required this.bloc, required this.reload});
  TrendingBloc bloc;
  Function reload;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<TrendingBloc, TrendingState>(
      bloc: bloc,
      listener: (context, state) async {
        if (state is TrendingErrorState) {
          await showAnimatedDialog2(
              context,
              NoConnectionDialog(
                reload: reload,
              ));
        }
      },
      builder: (context, state) {
        if (state is TrendingLoadedState) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
            child: CarouselSlider(
              options: CarouselOptions(
                height: AppSize.s150,
                autoPlay: true,
              ),
              items: state.trendingList.map((i) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.detailFoodRoute,
                        arguments: i);
                  },
                  child: Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        i.attachmentUrls[i.representIndex]),
                                    onError: (exception, stackTrace) =>
                                        const AssetImage(
                                            PicturePath.errorImagePath),
                                  )),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: CommonFoodTitle(
                                  isVegan: i.isVegan,
                                  title: i.title,
                                  fontSize: 16,
                                  height: 150 * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          );
        }
        if (state is TrendingLoadingState) {
          return const LoadingWidget();
        }
        if (state is TrendingErrorState) {
          return ErrorText(failure: state.failure);
        }
        return Container();
      },
    );
  }
}
