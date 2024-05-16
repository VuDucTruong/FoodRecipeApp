import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/domain/entity/chef_entity.dart';
import 'package:food_recipe_app/presentation/blocs/verified_chefs/verified_chefs_bloc.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/error_text.dart';
import 'package:food_recipe_app/presentation/common/widgets/stateless/loading_widget.dart';
import 'package:food_recipe_app/presentation/resources/assets_management.dart';
import 'package:food_recipe_app/presentation/resources/route_management.dart';
import 'package:food_recipe_app/presentation/resources/value_manament.dart';

class ChefList extends StatelessWidget {
  const ChefList({
    super.key,
    required this.verifiedChefsBloc,
  });

  final VerifiedChefsBloc verifiedChefsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifiedChefsBloc, VerifiedChefsState>(
      bloc: verifiedChefsBloc,
      builder: (context, state) {
        if (state is VerifiedChefsLoadingState) {
          return const LoadingWidget();
        }
        if (state is VerifiedChefsErrorState) {
          return ErrorText(
            failure: state.failure,
          );
        }
        if (state is VerifiedChefsLoadedState) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
            height: AppSize.s130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.verifiedChefList.length,
              itemBuilder: (context, index) {
                ChefEntity entity = state.verifiedChefList[index];
                return Container(
                  margin: const EdgeInsets.only(right: AppMargin.m8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.chefProfileRoute,
                          arguments: entity.id);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: AppSize.s80,
                          width: AppSize.s80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(entity.profileInfo.avatarUrl),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) =>
                                    const AssetImage(
                                        PicturePath.errorImagePath),
                              ),
                              borderRadius:
                                  BorderRadius.circular(AppRadius.r20),
                              color: Colors.amber),
                        ),
                        Container(
                          width: 80,
                          margin: const EdgeInsets.symmetric(
                              vertical: AppMargin.m4),
                          child: Text(
                            entity.profileInfo.fullName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
